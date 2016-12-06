//
//  MainViewController.h
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *MapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic)CLLocation *ultimaPosition;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic)NSString *usernameString;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIButton *arrowUpButton;
@property (weak, nonatomic) IBOutlet UILabel *userState;

@end
