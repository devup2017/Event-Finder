//
//  AppDelegate.m
//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "AppDelegate.h"
#import "GoogleMaps/GoogleMaps.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [GMSServices provideAPIKey:@"AIzaSyAWX5FWFWLiUUnBpa9PK2iPhQQ6QFCEVmw"];
    NSString *string = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedIn"];
    if( [string isEqualToString:@"Success"]){
     
        MainViewController *mainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"mainVC"];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:mainViewController];
        nc.navigationBar.barStyle = UIStatusBarStyleLightContent;
        nc.navigationBar.hidden = YES;
        self.window.rootViewController = nc;
        
    }else{
 
        LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"loginVC"];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:loginViewController];
        nc.navigationBar.barStyle = UIStatusBarStyleLightContent;
        nc.navigationBar.hidden = YES;
        self.window.rootViewController = nc;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
