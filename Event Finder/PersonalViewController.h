//
//  PersonalViewController.h
//  Event Finder
//
//  Created by Adrian on 8/12/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userStatus;
@property (weak, nonatomic) IBOutlet UIButton *changeBeaconButton;
@property (weak, nonatomic) IBOutlet UIButton *settinsButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *socialMediaButtons;
@end
