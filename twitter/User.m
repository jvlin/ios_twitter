//
//  User.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

@interface User()

- (void)populateAttributesWithDictionary:(NSDictionary *)dictionary;

@end

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";
NSString * const kCurrentUserKey = @"kCurrentUserKey";

@implementation User

static User *_currentUser;

+ (User *)currentUser {
    if (!_currentUser) {
        NSData *userData = [[NSUserDefaults standardUserDefaults] dataForKey:kCurrentUserKey];
        if (userData) {
            NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            _currentUser = [[User alloc] initWithDictionary:userDictionary];
            
            [_currentUser populateAttributesWithDictionary:userDictionary];

        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
    if (currentUser) {
        NSData *userData = [NSJSONSerialization dataWithJSONObject:currentUser.data options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kCurrentUserKey];
        NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
        
        [_currentUser populateAttributesWithDictionary:userDictionary];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserKey];
        [TwitterClient instance].accessToken = nil;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!_currentUser && currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
    } else if (_currentUser && !currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
    }
}

- (void)populateAttributesWithDictionary:(NSDictionary *)dictionary
{
    self.name = dictionary[@"name"];
    self.screenName = dictionary[@"screen_name"];
    self.profileImageURL = [NSURL URLWithString:dictionary[@"profile_image_url"]];
    
}

@end
