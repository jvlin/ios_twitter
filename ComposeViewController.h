//
//  ComposeViewController.h
//  twitter
//
//  Created by Joey Lin on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, strong) NSString *replyUserName;
@property (nonatomic, strong) NSString *replyStatusId;

@end
