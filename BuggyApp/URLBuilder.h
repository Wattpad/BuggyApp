//
//  URLBuilder.h
//  BuggyApp
//
//  Created by R. Tony Goold on 2016-03-16.
//  Copyright © 2016 WP Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLBuilder : NSObject

- (instancetype)initWithScheme:(NSString *)scheme
                          host:(NSString *)host;

- (void)setPath:(NSString *)path;
- (void)appendPath:(NSString *)path;

- (void)addQueryKey:(NSString *)key value:(id)value;

- (NSURL *)buildUrl;

@end
