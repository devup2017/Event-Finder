//
//  CreatEventViewController.m
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "CreatEventViewController.h"

@interface CreatEventViewController ()

@end

@implementation CreatEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];
    [self initWithLayer];
    //[[self navigationController]setNavigationBarHidden:NO];
    // Do any additional setup after loading the view.
}


-(void)initWithLayer{
    // view radius
    self.privacyView.layer.masksToBounds = YES;
    self.privacyView.layer.cornerRadius = 5;
    self.privacyView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.privacyView.layer.borderWidth = 1;
    
    //button radius
    self.eventColorButton.layer.cornerRadius = 8;
    self.createEvetnButton.layer.cornerRadius = 8;
    for(UIButton *button in self.privacyButtons){
        
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        button.layer.borderWidth = 1;
    }
    
    self.detailTextView.layer.cornerRadius = 5;
    self.detailTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.detailTextView.layer.borderWidth = 1;
    
    // TextFields Layer
    self.nameTextField.layer.cornerRadius = 5;
    self.nameTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.nameTextField.layer.borderWidth = 1;
    
    self.whereTextField.layer.cornerRadius = 5;
    self.whereTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.whereTextField.layer.borderWidth = 1;
    
    self.dateTextField.layer.cornerRadius = 5;
    self.dateTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.dateTextField.layer.borderWidth = 1;
    
    self.timeTextField.layer.cornerRadius = 5;
    self.timeTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.timeTextField.layer.borderWidth = 1;
}

- (IBAction)backButtonPressed:(id)sender {
    
    [[self navigationController]popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
