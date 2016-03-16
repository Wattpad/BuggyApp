//
//  Story.m
//  BuggyApp
//
//  Created by R. Tony Goold on 2016-03-16.
//  Copyright © 2016 WP Technology, Inc. All rights reserved.
//

#import "Story.h"

@implementation Story

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author {
    self = [super init];
    if (self) {
        _title = title;
        _author = author;
    }
    return self;
}

@end
