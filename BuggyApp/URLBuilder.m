//
//  URLBuilder.m
//  BuggyApp
//
//  Created by R. Tony Goold on 2016-03-16.
//  Copyright © 2016 WP Technology, Inc. All rights reserved.
//

#import "URLBuilder.h"

@interface URLBuilder ()

@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *parameters;

@end

@implementation URLBuilder

- (instancetype)initWithScheme:(NSString *)scheme host:(NSString *)host {
    self = [super init];
    if (self) {
        _scheme = scheme;
        _host = host;
        _path = @"/";
    }
    return self;
}

- (void)appendPath:(NSString *)path {
    self.path = [self.path stringByAppendingPathComponent:path];
}

- (void)addQueryKey:(NSString *)key value:(NSString *)value {
    self.parameters[key] = value;
}

- (NSURL *)buildUrl {
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"%@://%@%@",
                                  self.scheme, self.host, self.path];
    NSMutableArray *keyValues = [[NSMutableArray alloc] initWithCapacity:self.parameters.count];
    [self.parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id _Nonnull value, BOOL * _Nonnull stop) {
        NSString *keyValue = [[NSString alloc] initWithFormat:@"%@=%@",
                              key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        [keyValues addObject:keyValue];
    }];
    if (keyValues.count > 0) {
        [urlString appendString:@"?"];
        [urlString appendString:[keyValues componentsJoinedByString:@"&"]];
    }
    return [[NSURL alloc] initWithString:urlString];
}

@end
