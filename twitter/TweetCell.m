//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData
{
    self.nameLabel.text = self.tweet.userName;
    self.screenNameLabel.text = self.tweet.screenName;
    self.tweetTextView.text = self.tweet.tweetText;
    [self.tweetTextView setTextContainerInset:UIEdgeInsetsZero];

    [self.profileImageView setImageWithURL:self.tweet.profileImageURL];
}

@end
