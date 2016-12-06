//
//  FriendsViewController.h
//  Event Finder
//
//  Created by Adrian on 9/4/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *onlineFriendsCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *offlineFriendsCollectionView;
@property (strong, nonatomic) IBOutletCollection(UITabBarItem) NSArray *tabarItem;

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@end
