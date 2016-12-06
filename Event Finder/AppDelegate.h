//
//  AppDelegate.h
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString * unsername;
@property (strong, nonatomic) NSString * userstatus;
@property (strong, nonatomic) UIColor * color;
@property (strong, nonatomic) NSMutableDictionary *users;
@end

