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
            //NSLog(@"%@", params);
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
        self.favoritesCount = [dictionary[@"favorites_count"] intValue];
       
        //format date for tweet view controller
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss +zzzz yyyy"];
        NSDate *date = [dateFormat dateFromString:dictionary[@"created_at"]];
        [dateFormat setDateFormat:@"MM/dd/yyyy h:mm a"];
        self.createdAt = [dateFormat stringFromDate:date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss +zzzz yyyy"];
        NSDate *newDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
        
        //calculate time ago
        NSDate *now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSTimeInterval deltaTime = [now timeIntervalSinceDate:newDate];
        
        if (deltaTime < 60) {
            self.timeAgo = [NSString stringWithFormat:@"%ds",(int) deltaTime];
        } else if (deltaTime < 3600) {
            self.timeAgo = [NSString stringWithFormat:@"%dm",(int) (deltaTime/60)];
        } else if (deltaTime < 3600*48) {
            self.timeAgo = [NSString stringWithFormat:@"%dh",(int) (deltaTime/3600)];
        } else {
            self.timeAgo = [NSString stringWithFormat:@"%dd",(int) (deltaTime/3600/24)];
        }
        
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
                
    }
    
    return self;
}

@end
