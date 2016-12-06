//
//  SettingsViewController.h
//  Event Finder
//
//  Created by Adrian on 8/12/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *socialView;
@property (weak, nonatomic) IBOutlet UIButton *realName;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UIButton *socialLink;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextField *userStatus;
@property (weak, nonatomic) IBOutlet UIView *visibleView;
@property (weak, nonatomic) IBOutlet UIView *friensView;
@property (weak, nonatomic) IBOutlet UIView *invisibleView;

@end
