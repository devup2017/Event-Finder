//
//  PersonalViewController.m
//  Event Finder
//
//  Created by Adrian on 8/12/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "PersonalViewController.h"
#import "ChangeBeaconViewController.h"
#import "SettingsViewController.h"
#import "MainViewController.h"
@interface PersonalViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ConnectionButtons;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userFullName;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.changeBeaconButton.layer.cornerRadius = 5;
    self.settinsButton.layer.cornerRadius = 5;
    
}

-(void)viewWillAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"realnameFlag"] == true){
        self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"realname"];
    }else{
        self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"username"];
    }
    self.userStatus.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"state"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapConnectionStatus:(UIButton*)sender{
    UIImage *image = [UIImage imageNamed:@"check.png"];
    [sender setImage:image forState:UIControlStateNormal];
}

- (IBAction)change_beacon_pressed:(id)sender {
    
    ChangeBeaconViewController * viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"changeBeaconVC"];
    [[self navigationController]pushViewController:viewcontroller animated:YES];

    
}

- (IBAction)setting_pressed:(id)sender {
    
    SettingsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsVC"];
    [[self navigationController]pushViewController:viewController animated:YES];
}


- (IBAction)popViewController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)connectSocialSite:(UIButton*)sender {
    
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


@end
