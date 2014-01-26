//
//  TweetViewController.m
//  twitter
//
//  Created by Joey Lin on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetViewController.h"
#import "ComposeViewController.h"

@interface TweetViewController ()

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
- (IBAction)onFavoriteIcon:(id)sender;
- (IBAction)onRetweetIcon:(id)sender;
- (IBAction)onReplyIcon:(id)sender;

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
    self.retweetsLabel.text = [NSString stringWithFormat:@"%i RETWEETS", self.tweet.retweetCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%i FAVORITES", self.tweet.favoritesCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFavoriteIcon:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favorite Successful" message:@"You have favorited this status!" delegate:nil cancelButtonTitle:@"OK"        otherButtonTitles:nil];
    NSLog(@"favoriting status with id: %@", self.tweet.statusId);

    [[TwitterClient instance] favoriteStatusWithId:self.tweet.statusId success:^(AFHTTPRequestOperation *operation, id response) {
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //handle error
        NSLog(@"Error favoriting");
        NSLog(@"%@", error);
    }];
}

- (IBAction)onRetweetIcon:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Retweet Successful"              message:@"You have retweeted this status!"
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [[TwitterClient instance] retweetStatusWithId:self.tweet.statusId success:^(AFHTTPRequestOperation *operation, id response) {
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //handle error
        NSLog(@"Error favoriting");
        NSLog(@"%@", error);
    }];
}

- (IBAction)onReplyIcon:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.isReply = YES;
    cvc.replyUserName = self.tweet.screenName;
    cvc.replyStatusId = self.tweet.statusId;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cvc];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
@end
