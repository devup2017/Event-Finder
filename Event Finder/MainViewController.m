//
//  MainViewController.m//  Event Finder
//
//  Created by Adrian on 7/22/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "MainViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "NavigateButtons.h"
#import "PersonalViewController.h"
#import "CreatEventViewController.h"
#import "FriendsViewController.h"
#import "AppDelegate.h"

@interface MainViewController () <GMSMapViewDelegate, CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(strong, nonatomic)GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) UILabel *event;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIView *socialView;

@end

@implementation MainViewController
GMSMarker *marker;
UIImageView *imageView;
@synthesize locationManager;

-(CLLocation *)ultimaPosition {
    if(!_ultimaPosition){
        _ultimaPosition = [[CLLocation alloc]init];
    }
    return _ultimaPosition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    _eventsArray = [[NSMutableArray alloc]initWithObjects:@"Sports Event",@"Promotional Event",@"Fundraising Event",@"Garage Sale",@"Party",@"Giveaways",@"Social",@"Eastate Sale",@"Other",@"",@"", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if(_socialView || _searchView){
        [_socialView removeFromSuperview];
        [_searchView removeFromSuperview];
    }
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"realnameFlag"] == true){
        self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"realname"];
    }else{
        self.username.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] objectForKey:@"username"];
    }
    
    self.userState.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]objectForKey:@"state"];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSString *string = [NSString stringWithFormat:@"%f",self.locationManager.location.coordinate.latitude];
    NSLog(@"Location%@",string);
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"colourBeacon1.png"];
    imageView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    imageView.layer.borderWidth = 2.0;
    imageView.layer.cornerRadius = 10;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:15];
    CGRect rect = CGRectMake(self.mapView.bounds.origin.x,self.mapView.bounds.origin.y, self.MapView.bounds.size.width, self.MapView.bounds.size.height);
    _mapView = [GMSMapView mapWithFrame:rect camera:camera];
    
    _mapView.mapType = kGMSEarthRadius;
    
    [self.MapView addSubview:_mapView];
    
    marker = [[GMSMarker alloc]init];
    marker.position = CLLocationCoordinate2DMake(51.5098, -0.1337);
    
    //marker.snippet = @"Wyatt";
    marker.iconView = imageView;

    marker.groundAnchor = CGPointMake(0.5f, 1.0f);
    
    marker.map = _mapView;
    _mapView.myLocationEnabled = YES;
    _mapView.settings.compassButton = true;
    _mapView.settings.myLocationButton = true;
    
    _mapView.delegate = self;
    [self initWithButtons];
}
#pragma initialize taps on google map

- (void)initWithButtons {
    
    self.imageButton.layer.cornerRadius = 20;
    
    CGFloat superViewWidth = self.view.frame.size.width;
    CGFloat superViewHeight = self.view.frame.size.height;
    CGFloat buttonheight = superViewHeight * 126/2208;
    CGFloat buttonWidth = buttonheight;
    
    CGRect eventButtonRect = CGRectMake(superViewWidth * 45/1242, superViewHeight * 36/2208, buttonWidth, buttonheight);
    NavigateButtons *eventButton = [[NavigateButtons alloc]initWithFrame:eventButtonRect];
    [eventButton setImage:[UIImage imageNamed:@"navigationbtn1.png"] forState:UIControlStateNormal];
    [eventButton addTarget:self action:@selector(eventButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect infoButtonRect = CGRectMake(superViewWidth * 45/1242, superViewHeight * 190/2208, buttonWidth, buttonheight);
    NavigateButtons *infoButton = [[NavigateButtons alloc]initWithFrame:infoButtonRect];
    [infoButton setImage:[UIImage imageNamed:@"navigationbtn2.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(infoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect socialButtonRect = CGRectMake(superViewWidth * 1071/1242, superViewHeight * 36/2208, buttonWidth, buttonheight);
    NavigateButtons *socialButton = [[NavigateButtons alloc]initWithFrame:socialButtonRect];
    [socialButton setImage:[UIImage imageNamed:@"navigationbtn4.png"] forState:UIControlStateNormal];
    [socialButton addTarget:self action:@selector(socialButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect flyButtonRect = CGRectMake(superViewWidth * 1071/1242, superViewHeight * 190/2208, buttonWidth, buttonheight);
    NavigateButtons *flyButton = [[NavigateButtons alloc]initWithFrame:flyButtonRect];
    [flyButton setImage:[UIImage imageNamed:@"navigationbtn3.png"] forState:UIControlStateNormal];
    [flyButton addTarget:self action:@selector(flyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect navButtonRect = CGRectMake(superViewWidth * 1080/1242, superViewHeight * 340/2208, buttonWidth * 0.9, buttonheight * 0.9);
    NavigateButtons *navButton = [[NavigateButtons alloc]initWithFrame:navButtonRect];
    [navButton setImage:[UIImage imageNamed:@"navigationbtn5.png"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(compassAppear) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView addSubview:eventButton];
    [_mapView addSubview:infoButton];
    [_mapView addSubview:socialButton];
    [_mapView addSubview:flyButton];
    [_mapView addSubview:navButton];
    
}


-(void)eventButtonPressed{
    
    CreatEventViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventVC"];
//    [self presentViewController:VC animated:YES completion:nil];
    [[self navigationController]pushViewController:VC animated:YES];
    
}

-(void)infoButtonPressed{
    
    _event = [[UILabel alloc]init];
    CGFloat superviewWidth = self.view.frame.size.width;
    CGFloat superviewHeight = self.view.frame.size.height;
    
    CGFloat infoviewHeight = superviewHeight * 282/2208;
    UIView *informationView = [[UIView alloc]initWithFrame:CGRectMake(0, self.statusView.frame.size.height, superviewWidth, infoviewHeight)];
    informationView.backgroundColor = [UIColor whiteColor];
    
    UIView *colorSubView = [[UIView alloc]initWithFrame:CGRectMake((superviewWidth - superviewWidth * 1080/1242)/2, infoviewHeight * 66/288, superviewWidth * 1080/1242, infoviewHeight * 75/282)];
    
    
    // Different coloured flags of events

    UIColor *color0 = [UIColor colorWithRed:242.0f/255.0f
                                      green:0.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f];
    UIColor *color1 = [UIColor colorWithRed:230.0f/255.0f
                                      green:50.0f/255.0f
                                       blue:7.0f/255.0f
                                      alpha:1.0f];
    UIColor *color2 = [UIColor colorWithRed:237.0f/255.0f
                                      green:230.0f/255.0f
                                       blue:44.0f/255.0f
                                      alpha:1.0f];
    UIColor *color3 = [UIColor colorWithRed:83.0f/255.0f
                                      green:193.0f/255.0f
                                       blue:2.0f/255.0f
                                      alpha:1.0f];
    UIColor *color4 = [UIColor colorWithRed:0.0f/255.0f
                                      green:66.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f];
    UIColor *color5 = [UIColor colorWithRed:131.0f/255.0f
                                      green:51.0f/255.0f
                                       blue:241.0f/255.0f
                                      alpha:1.0f];
    UIColor *color6 = [UIColor colorWithRed:236.0f/255.0f
                                      green:14.0f/255.0f
                                       blue:233.0f/255.0f
                                      alpha:1.0f];
    UIColor *color7 = [UIColor colorWithRed:22.0f/255.0f
                                      green:20.0f/255.0f
                                       blue:20.0f/255.0f
                                      alpha:1.0f];
    UIColor *color8 = [UIColor colorWithRed:56.0f/255.0f
                                      green:4.0f/255.0f
                                       blue:4.0f/255.0f
                                      alpha:1.0f];
    UIColor *color9 = [UIColor colorWithRed:106.0f/255.0f
                                      green:107.0f/255.0f
                                       blue:107.0f/255.0f
                                      alpha:1.0f];
    
    UIColor *color10 = [UIColor colorWithRed:255.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f];
    
    NSMutableArray *colorArray = [[NSMutableArray alloc]initWithObjects:color0,color1,color2,color3,color4,color5,color6,color7,color8,color9,color10, nil];
//    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    UIColor * color = appDelegate.color;
    
    for(int i=0;i<11;i++){
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * colorSubView.frame.size.width/11, 0, colorSubView.frame.size.width/11, colorSubView.frame.size.height)];
        [button setTag:i];
        [button setBackgroundColor:[colorArray objectAtIndex:i]];
        [button addTarget:self action:@selector(colorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if(i == [[NSUserDefaults standardUserDefaults]integerForKey:@"statusIndex"]){
            button.layer.borderWidth = 2.0;
            button.layer.borderColor = [[UIColor darkGrayColor]CGColor];
        }
        
        [colorSubView addSubview:button];
    }
    
    [informationView addSubview:colorSubView];
    
    // Type of Event according to selected color
    _event = [[UILabel alloc]initWithFrame:CGRectMake(superviewWidth * 0.25, infoviewHeight * 180/288, superviewWidth * 0.5, 20)];
    _event.textColor = [UIColor blackColor];
    _event.font = [UIFont systemFontOfSize:18];
    _event.textAlignment = NSTextAlignmentCenter;
    _event.text = [_eventsArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"statusIndex"]];
    [informationView addSubview: _event];
   
     //swipe up
    [self.mapView setUserInteractionEnabled:YES];
    [self.MapView setUserInteractionEnabled:YES];
    [informationView setUserInteractionEnabled:YES];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    [informationView addGestureRecognizer:swipeUp];
  
    [self.view addSubview:informationView];
}

-(void)socialButtonPressed{
    
    _socialView = [[UIView alloc]initWithFrame:CGRectMake(0, self.footerView.frame.size.height, self.footerView.frame.size.width * 1040/1242, self.footerView.frame.size.height * 0.9)];
    _socialView.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberofOnlineFriends = [[UILabel alloc]initWithFrame:CGRectMake(_socialView.frame.size.width * 135/1040, _socialView.frame.size.height * 35/258, _socialView.frame.size.width * 58/1040, _socialView.frame.size.height * 96/259)];
    numberofOnlineFriends.text = @"2";
    numberofOnlineFriends.textColor = [UIColor colorWithRed:60.0f/255.0f green:189.0f/255.0f blue:71.0f/255.0f alpha:1.0];
    
    UILabel *numberofOfflineFriends = [[UILabel alloc]initWithFrame:CGRectMake(_socialView.frame.size.width * 135/1040, _socialView.frame.size.height * 133/258, _socialView.frame.size.width * 58/1040, _socialView.frame.size.height * 96/259)];
    numberofOfflineFriends.text = @"1";
    numberofOfflineFriends.textColor = [UIColor colorWithRed:178.0f/255.0f green:115.0f/255.0f blue:214.0f/255.0f alpha:1.0];
    
    UILabel *onlineFriends = [[UILabel alloc]initWithFrame:CGRectMake(_socialView.frame.size.width * 239/1040, _socialView.frame.size.height * 35/258, _socialView.frame.size.width * 395/1040, _socialView.frame.size.height * 96/259)];
    onlineFriends.text = @"Friends Online";
    onlineFriends.textColor = [UIColor blackColor];
    
    UILabel *offlineFriends = [[UILabel alloc]initWithFrame:CGRectMake(_socialView.frame.size.width * 239/1040, _socialView.frame.size.height * 133/258, _socialView.frame.size.width * 395/1040, _socialView.frame.size.height * 96/259)];
    offlineFriends.text = @"Friends Offline";
    offlineFriends.textColor = [UIColor blackColor];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(_socialView.frame.size.width * 561/1040, _socialView.frame.size.height * 5/258, _socialView.frame.size.width * 114/1040, _socialView.frame.size.height * 30/259)];
    [button setBackgroundImage:[UIImage imageNamed:@"arrowUp.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(arrowUpPressedIn) forControlEvents:UIControlEventTouchUpInside];
    
    [_socialView addSubview:numberofOnlineFriends];
    [_socialView addSubview:numberofOfflineFriends];
    [_socialView addSubview:onlineFriends];
    [_socialView addSubview:offlineFriends];
    [_socialView addSubview: button];
    
    
    CGRect newFrame = CGRectMake(0, self.footerView.frame.size.height * 0.1, self.footerView.frame.size.width * 1040/1242, self.footerView.frame.size.height * 0.9);
    [UIView animateWithDuration:0.5 animations:^{
        
        _socialView.frame = newFrame;
    }];
    
    [self.footerView addSubview:_socialView];
    
}

-(void)flyButtonPressed{
    
    CLLocation *location = _mapView.myLocation;
    [_mapView animateToLocation:location.coordinate];
}

-(void)compassAppear{
    
    UIEdgeInsets mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0);
    _mapView.settings.compassButton = true;
    _mapView.padding = mapInsets;
}

-(IBAction)arrowUpButtonPressed:(id)sender{
    
    PersonalViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"personalVC"];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    nc.navigationBar.barStyle = UIStatusBarStyleLightContent;
    nc.navigationBar.hidden = YES;
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)colorButtonPressed:(UIButton *)sender{
    
    _event.text = [_eventsArray objectAtIndex:sender.tag];
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender{
    
    if(sender.direction == UISwipeGestureRecognizerDirectionUp){
        UIView *view = sender.view;
        [view removeFromSuperview];
    }
}
-(void)arrowUpPressedIn
{
    FriendsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsVC"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)imageButtonPressed:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageButton setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)searchButtonPressed:(id)sender {
    
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width, self.footerView.frame.size.height * 0.1, self.footerView.frame.size.width * 1040/1242, self.footerView.frame.size.height * 0.9)];
    _searchView.backgroundColor = [UIColor whiteColor];
    UITextField * searchBar = [[UITextField alloc]initWithFrame:CGRectMake(_searchView.frame.size.width * 78/1040, _searchView.frame.size.height * 55/258, _searchView.frame.size.width * 636/1040, _searchView.frame.size.height * 126/259)];
    searchBar.placeholder = @"Search";
    searchBar.backgroundColor = [UIColor colorWithRed:212.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    searchBar.layer.cornerRadius = 5;
    
    [_searchView addSubview:searchBar];
    
    UIView *distance = [[UIView alloc]initWithFrame:CGRectMake(_searchView.frame.size.width * 759/1040, _searchView.frame.size.height * 55/258, _searchView.frame.size.width * 282/1040, _searchView.frame.size.height * 126/259)];
    distance.backgroundColor = [UIColor colorWithRed:212.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    distance.layer.cornerRadius = 5;
    
    UIButton *menu = [[UIButton alloc]initWithFrame:CGRectMake(distance.frame.size.width * 24/282, distance.frame.size.height * 36/126, distance.frame.size.width * 24/282, distance.frame.size.height * 57/126)];
    [menu setImage:[UIImage imageNamed:@"arrowLeft.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(menubuttonpressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *distancewithKm = [[UILabel alloc]initWithFrame: CGRectMake(distance.frame.size.width * 93/282, distance.frame.size.height * 36/126, distance.frame.size.width * 162/282, distance.frame.size.height * 51/126)];
    distancewithKm.text = @"25 km";
    
    [distance addSubview:menu];
    [distance addSubview:distancewithKm];
    
    [_searchView addSubview:distance];
    CGRect newFrame = CGRectMake(0, self.footerView.frame.size.height * 0.1, self.footerView.frame.size.width * 1040/1242, self.footerView.frame.size.height * 0.9);
    [UIView animateWithDuration:0.5f animations:^{
        _searchView.frame = newFrame;
    }];
    [self.footerView addSubview:_searchView];
   }

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    
}


-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{

    return false;
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(_mapView.selectedMarker.infoWindowAnchor.x, _mapView.selectedMarker.infoWindowAnchor.y, self.view.frame.size.width * 652/1242, self.view.frame.size.height * 645/2208)];
    view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
    // add components to infoWindow
    CGFloat infoWindowWidth = view.frame.size.width;
    CGFloat infoWindowHeight = view.frame.size.height;
    UILabel *username = [[UILabel alloc]initWithFrame:CGRectMake(infoWindowWidth * 42/652, infoWindowHeight * 36/645, infoWindowWidth * 0.8, 20 )];
    username.text = @"David Beckham";
    username.textColor = [UIColor colorWithRed:60.0f/255.0f green:189.0f/255.0f blue:71.0f/255.0f alpha:1.0];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(infoWindowWidth * 42/652, infoWindowHeight * 101/645, infoWindowWidth * 0.8, 20)];
    message.text = @"I am in Hotel";
    message.textColor = [UIColor blackColor];
    
    NSMutableArray *buttonArray = [[NSMutableArray alloc]initWithObjects:@"fbButton.png",@"twtButton.png",@"instButton.png",@"linButton.png", nil];
    for(int i = 0; i<4 ; i++){
        UIButton * socilaMedia = [[UIButton alloc]initWithFrame:CGRectMake(infoWindowWidth * 42/652, i * infoWindowHeight*92/645 + infoWindowHeight * 181/645, infoWindowWidth * 564/652, infoWindowHeight * 74/645)];
        socilaMedia.tag = i;
        [socilaMedia setBackgroundImage:[UIImage imageNamed:[buttonArray objectAtIndex:i]] forState:UIControlStateNormal];
        [view addSubview: socilaMedia];
    }
    
    UIButton *friendRequest = [[UIButton alloc]initWithFrame:CGRectMake(infoWindowWidth * 42/652, infoWindowHeight * 549/652, infoWindowWidth * 273/652, infoWindowHeight * 69/645)];
    friendRequest.layer.cornerRadius = 2;
    [friendRequest setBackgroundColor:[UIColor colorWithRed:60.0f/255.0f green:189.0f/255.0f blue:71.0f/255.0f alpha:1.0]];
    [friendRequest setTitle:@"Friend Request" forState:UIControlStateNormal];
    [friendRequest.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    UIButton *blockUser = [[UIButton alloc]initWithFrame:CGRectMake(infoWindowWidth * 335/652, infoWindowHeight * 549/652, infoWindowWidth * 273/652, infoWindowHeight * 69/645)];
    blockUser.layer.cornerRadius = 2;
    [blockUser setBackgroundColor:[UIColor colorWithRed:178.0f/255.0f green:115.0f/255.0f blue:214.0f/255.0f alpha:1.0]];
    [blockUser setTitle:@"Block User" forState:UIControlStateNormal];
    [blockUser.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [view addSubview:username];
    [view addSubview:message];
    [view addSubview:friendRequest];
    [view addSubview:blockUser];
        return view;
}

-(void)menubuttonpressed:(UIButton *)sender{
    
    CGRect rect = CGRectMake(-self.view.frame.size.width, self.footerView.frame.size.height * 0.1, self.footerView.frame.size.width * 1040/1242, self.footerView.frame.size.height * 0.9);
    [UIView animateWithDuration:0.5f animations:^{
        
        _searchView.frame = rect;
    }];
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    NSLog(@"didUpdateLocations");
//    CLLocation *ultimaPos = [locations lastObject];
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(_ultimaPosition.coordinate.latitude, _ultimaPosition.coordinate.longitude);
//    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:center zoom:18.0];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        _ultimaPosition = ultimaPos;
//        [_mapView animateWithCameraUpdate:updatedCamera];
//        
//        marker.position = center;
//        marker.snippet = @"Wyatt";
//        marker.appearAnimation = kGMSMarkerAnimationPop;
//        [_mapView animateToLocation:center];
//        marker.map = _mapView;
//    });
//}

//-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
//    [UIView animateWithDuration:5.0 animations:^{
//        imageView.tintColor = [UIColor blueColor];
//    }
//                     completion:^(BOOL finished){
//                         marker.tracksViewChanges = NO;
//                     }];
//}
@end
