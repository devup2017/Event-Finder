//
//  CreatEventViewController.h
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *privacyView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *privacyButtons;

@property (weak, nonatomic) IBOutlet UIButton *eventColorButton;
@property (weak, nonatomic) IBOutlet UIButton *createEvetnButton;
@property (weak, nonatomic) IBOutlet UIButton *dropdownButton;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *whereTextField;


@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@end
