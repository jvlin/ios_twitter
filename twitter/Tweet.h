//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *text;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@property (nonatomic, strong) NSURL *profileImageURL;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *tweetText;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, assign) int retweetCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
