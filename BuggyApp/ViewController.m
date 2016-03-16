//
//  ViewController.m
//  BuggyApp
//
//  Created by R. Tony Goold on 2016-03-16.
//  Copyright © 2016 WP Technology, Inc. All rights reserved.
//

#import "ViewController.h"

#import "Story.h"
#import "URLBuilder.h"

@interface ViewController () <NSURLSessionDataDelegate>

@property (nonatomic, strong, readonly) NSMutableData *responseData;
@property (nonatomic, strong) NSArray<Story *> *stories;

- (NSArray<Story *> *)storiesFromData:(NSData *)data;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _responseData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSURLSessionConfiguration *config = [[NSURLSessionConfiguration alloc] init];
    config.HTTPAdditionalHeaders = @{ @"User-Agent": @"X-WP-BuggyApp" };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:nil];

    URLBuilder *builder = [[URLBuilder alloc] initWithScheme:@"https" host:@"www.wattpad.com"];
    [builder appendPath:@"/api/v3/stories"];
    [builder addQueryKey:@"offset" value:@0];
    [builder addQueryKey:@"limit" value:@10];
    [builder addQueryKey:@"fields" value:@"stories(id,title,user)"];
    NSURL *url = [builder buildUrl];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                              timeoutInterval:5.0];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if (error != nil) {
        NSLog(@"Error: %@", error);
        return;
    }

    self.stories = [self storiesFromData:self.responseData];
    [self.tableView reloadData];
}

- (NSArray<Story *> *)storiesFromData:(NSData *)data {
    NSMutableString *titleBuffer = [[NSMutableString alloc] init];
    NSMutableString *authorBuffer = [[NSMutableString alloc] init];
    NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:NULL];
    NSArray<NSDictionary *> *storiesJson = responseJson[@"stories"];
    NSMutableArray<Story *> *stories = [[NSMutableArray alloc] init];
    [storiesJson enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleBuffer setString:@"Story: "];
        [titleBuffer appendString:json[@"title"]];
        [authorBuffer setString:@"Author: "];
        [authorBuffer appendString:json[@"user"][@"name"]];
        Story *story = [[Story alloc] initWithTitle:titleBuffer author:authorBuffer];
        [stories addObject:story];
    }];
    return stories;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storyCell"
                                                            forIndexPath:indexPath];
    Story *story = self.stories[indexPath.row];
    cell.textLabel.text = story.title;
    cell.detailTextLabel.text = story.author;
    return cell;
}

@end
