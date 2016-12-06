//
//  WelcomeViewController.h
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (nonatomic) UITapGestureRecognizer *tapReconizer;
@end
