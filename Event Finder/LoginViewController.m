//
//  LoginViewController.m
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TermsViewController.h"
#import "AppDelegate.h"
#import "UserData.h"
@interface LoginViewController () <UIScrollViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.imageArray = [[NSArray alloc] initWithObjects:@"instructionImage1.png", @"instructionImage1.png", @"instructionImage1.png", @"instructionImage1.png",@"instructionImage1.png", nil];
    
    for (int i = 0; i < [self.imageArray count]; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:i]];

        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.imageArray count], self.scrollView.frame.size.height);
    self.scrollView.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pageScroll:(id)sender {
    
    int page = ((UIPageControl *)sender).currentPage;
    // update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)loginButtonPressed:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             [self getresult];
             NSString *string = @"Success";
             [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"loggedIn"];
             WelcomeViewController * welcomeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"welcomVC"];
             [[self navigationController]pushViewController:welcomeVC animated:YES];
         }
     }];
    
}

-(void)getresult{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         
         if (!error) {
             NSLog(@"%@",result[@"name"]);
             UserData *user = [[UserData alloc]init];
             [user createDictionary:@"realname" value:result[@"name"]];
         }
     }];

}

- (IBAction)pushTermsView:(id)sender {
    
    TermsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"termsVC"];
    [[self navigationController]pushViewController:vc animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}



@end
