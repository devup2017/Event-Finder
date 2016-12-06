//
//  WelcomeViewController.m
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "UserData.h"
@interface WelcomeViewController () <UITextFieldDelegate>

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];
    self.tapReconizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAnywhere:)];
    self.tapReconizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapReconizer];
    
    self.nextButton.layer.cornerRadius = 5;
    self.username.delegate  = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)buttonPressed:(id)sender {
    
    if(self.username.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warnning!" message:@"You must input UserName" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesButtton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:yesButtton];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        UserData *user = [[UserData alloc]init];
        [user createDictionary:@"username" value:self.username.text];
        MainViewController *mainVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
        mainVC.usernameString = self.username.text;
        [[self navigationController ]pushViewController:mainVC animated:YES];
    }
    
}
- (IBAction)backToSign:(id)sender {
    
    [[self navigationController]popToRootViewControllerAnimated:YES];
}

-(void)didTapAnywhere:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
