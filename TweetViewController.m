//
//  TweetViewController.m
//  twitter
//
//  Created by Joey Lin on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTweet:(Tweet *)tweet
{
    self = [super init];
    if (self) {
        self.tweet = tweet;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.tweet.profileImageURL];
    self.profileImageView.image = [UIImage imageWithData:imageData];
    self.nameLabel.text = self.tweet.userName;
    self.screenNameLabel.text = self.tweet.screenName;
    self.tweetTextLabel.text = self.tweet.tweetText;
    self.tweetTextLabel.frame = CGRectMake(20,20,260,800);
    self.tweetTextLabel.numberOfLines = 0;
    [self.tweetTextLabel sizeToFit];
    self.createdAtLabel.text = self.tweet.createdAt;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
