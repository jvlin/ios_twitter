//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    int count = 0;
    //NSLog(@"%@", array);

    for (NSDictionary *params in array) {
        if (count == 0) {
            //NSDictionary *user = [params //valueForKeyPath:@"user"];
            //NSLog(@"%@", params.allKeys);
        }

        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
        count++;
    }
    return tweets;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //initialize properties
        NSDictionary *user = [dictionary valueForKeyPath:@"user"];
        self.screenName = user[@"screen_name"];
        self.userName = [user valueForKey:@"name"];
        self.tweetText = dictionary[@"text"];
        self.profileImageURL = [NSURL URLWithString:user[@"profile_image_url"]];
    }
    
    return self;
}

@end
