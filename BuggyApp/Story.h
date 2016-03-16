//
//  Story.h
//  BuggyApp
//
//  Created by R. Tony Goold on 2016-03-16.
//  Copyright © 2016 WP Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *author;

- (instancetype)initWithTitle:(NSString *)title
                       author:(NSString *)author;

@end
