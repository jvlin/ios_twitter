//
//  ComposeViewController.m
//  twitter
//
//  Created by Joey Lin on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (strong, nonatomic) User *currentUser;

- (void)onTweetButton;
- (void)onCancelButton;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentUser = [User currentUser];
    self.nameLabel.text = self.currentUser.name;
    NSLog(@"%@",self.currentUser.name);
    self.screenNameLabel.text = self.currentUser.screenName;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.currentUser.profileImageURL];
    self.profileImageView.image = [UIImage imageWithData:imageData];
    //NSLog(@"%@", self.currentUser);
    
    self.composeTextView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];

}

- (void)onTweetButton {

    // this should be fast.
    [[TwitterClient instance] postTweetWithText:self.composeTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        [self onCancelButton];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // do nothing
    }];
    
}

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    [textView setTextColor:[UIColor blackColor]];
}

@end
