//
//  SettingsViewController.m
//  Event Finder
//
//  Created by Adrian on 8/12/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserData.h"
@interface SettingsViewController () <UITextFieldDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.socialView.layer.masksToBounds = YES;
    self.socialView.layer.cornerRadius = 5;
    self.socialView.layer.shadowOffset = CGSizeMake(-2, 5);
    self.socialView.layer.shadowRadius = 5;
    self.socialView.layer.shadowOpacity = 0.5;
    self.socialView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.socialView.layer.borderWidth = 1;
    
    self.realName.layer.cornerRadius = 5;
    self.userName.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"realnameFlag"] == false){
       self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"username"];
    }else{
        self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]objectForKey:@"realname"];
    }
    
    self.userStatus.placeholder = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"state"];
    self.userStatus.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    UserData *user = [[UserData alloc]init];
    [user createDictionary:@"state" value:self.userStatus.text];
    [[self navigationController]popViewControllerAnimated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)socialLink:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:{
            NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/"];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
            
        case 2:{
            NSURL *url = [NSURL URLWithString:@"https://twitter.com/"];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
            
        case 3:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/"]];
        }
            break;
            
        case 4:{
            NSURL *url = [NSURL URLWithString:@"https://www.linkedin.com/"];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
            
        default:
            break;
    }

}
- (IBAction)chagngeVisibleAndInvisible:(UIButton*)sender {
    UIColor *selectedColor = self.realName.backgroundColor;
    UIColor *unselectedColor = self.socialView.backgroundColor;
    switch (sender.tag) {
        case 1:
        {
            self.visibleView.backgroundColor = selectedColor;
            self.friensView.backgroundColor = unselectedColor;
            self.invisibleView.backgroundColor = unselectedColor;
            
        }
            break;
            
        case 2:
        {
            self.friensView.backgroundColor = selectedColor;
            self.visibleView.backgroundColor = unselectedColor;
            self.invisibleView.backgroundColor = unselectedColor;
        }
            break;
        case 3:
        {
            self.invisibleView.backgroundColor = selectedColor;
            self.friensView.backgroundColor = unselectedColor;
            self.visibleView.backgroundColor = unselectedColor;
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)realNameSetting:(id)sender {
    
    self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]objectForKey:@"realname"];
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"realnameFlag"];

}

- (IBAction)usernameSetting:(id)sender {
    
    self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]objectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]setBool:false forKey:@"realnameFlag"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UserData *user = [[UserData alloc]init];
    [user createDictionary:@"state" value:textField.text];
}

@end
