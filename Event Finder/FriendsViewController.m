//
//  FriendsViewController.m
//  Event Finder
//
//  Created by Adrian on 9/4/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "FriendsViewController.h"
#import "OnlineFriendsCell.h"
#import "OfflineFriendsCell.h"
#import "MainViewController.h"

@interface FriendsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UITabBarDelegate>{
    UICollectionViewFlowLayout *onLineflowLayout;
    UICollectionViewFlowLayout *OfflineflowLayout;
}
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    float cellWidth = (self.onlineFriendsCollectionView.frame.size.width) * 1179/1242;
    float cellHeight = (self.onlineFriendsCollectionView.frame.size.height) * 183/1092;
    
    onLineflowLayout = [[UICollectionViewFlowLayout alloc] init];
    [onLineflowLayout setItemSize:CGSizeMake(cellWidth, cellHeight)];
    onLineflowLayout.minimumLineSpacing = 10.0f;
    [self.onlineFriendsCollectionView setCollectionViewLayout:onLineflowLayout];
    
    OfflineflowLayout = [[UICollectionViewFlowLayout alloc] init];
    [OfflineflowLayout setItemSize:CGSizeMake(cellWidth, cellHeight)];
    OfflineflowLayout.minimumLineSpacing = 10.0f;
    [self.offlineFriendsCollectionView setCollectionViewLayout:OfflineflowLayout];
    
    for (UITabBarItem *item in self.tabarItem){
        
        item.image = [self imageWithImage:item.image scaledToSize:CGSizeMake(30, 30)];
        item.selectedImage = [self imageWithImage:item.selectedImage scaledToSize:CGSizeMake(30,30)];
        
    }
    
    self.tabBar.tintColor = [UIColor whiteColor];

}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(collectionView == self.onlineFriendsCollectionView){
        
        int sections = 1;
        //    if (self.imagesArray.count % 2 == 1) {
        //        sections += 1;
        //    }
        
        return sections;
    }else{
        int sections = 1;
        //    if (self.imagesArray.count % 2 == 1) {
        //        sections += 1;
        //    }
        
        return sections;
        
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView == self.onlineFriendsCollectionView){
        
        int rows = 8;
        return rows;
    }else{
        
        int rows = 5;
        return rows;

    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView == self.onlineFriendsCollectionView){
        
        static NSString *identifier = @"onlineFriendsCell";
        OnlineFriendsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //    if(self.imagesArray !=NULL){
        //
        //        cell.imgGymoji.image = [self.imagesArray objectAtIndex:index];
        //    }
        cell.photo.image = [UIImage imageNamed:@"photo.png"];
        
        return  cell;
    }else{
        
        static NSString *identifier = @"offlineFriendsCell";
        OfflineFriendsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //    if(self.imagesArray !=NULL){
        //
        //        cell.imgGymoji.image = [self.imagesArray objectAtIndex:index];
        //    }
        cell.photo.image = [UIImage imageNamed:@"girlPhoto.png"];
        
        return cell;
    }

}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
//    
//    GymojiCell *cell = (GymojiCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{cell.imgGymoji.transform=CGAffineTransformMakeScale(1.2, 1.2);} completion:^(BOOL finished){
//        cell.imgGymoji.transform = CGAffineTransformIdentity;
//    }];
//    
//    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    
//    NSData *data = UIImagePNGRepresentation(cell.imgGymoji.image);
//    
//    [pasteboard setData:data forPasteboardType:@"public.png"];
//    
//    if(pasteboard){
//        
//        //copy image to clipboard
//        UIView *notificationView= [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.1, self.view.frame.size.width, 20)];
//        notificationView.backgroundColor = [UIColor greenColor];
//        UILabel *notification = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, notificationView.frame.size.width, notificationView.frame.size.height)];
//        notification.text = @"Gymoji copied to clipboard!";
//        notification.textColor = [UIColor whiteColor];
//        notification.textAlignment = NSTextAlignmentCenter;
//        [notificationView addSubview:notification];
//        
//        [notificationView setAlpha:0.0f];
//        
//        //fade in
//        [UIView animateWithDuration:1.0f animations:^{
//            
//            [notificationView setAlpha:1.0f];
//            
//        } completion:^(BOOL finished) {
//            
//            //fade out
//            [UIView animateWithDuration:0.5f animations:^{
//                
//                [notificationView setAlpha:0.0f];
//                
//            } completion:nil];
//            
//        }];
//        
//        [self.view addSubview:notificationView];
//    }
//    
//    
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (IBAction)backButtonPressed:(id)sender {
//    
//    MainViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
//    [[self navigationController]popToViewController:viewcontroller animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


@end
