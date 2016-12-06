//
//  ChangeBeaconViewController.m
//  Event Finder
//
//  Created by Adrian on 8/12/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "ChangeBeaconViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface ChangeBeaconViewController ()
@property (nonatomic, strong) NSMutableArray *countrybeaconArray;
@property (nonatomic, strong) NSMutableArray *colourbeaconArray;
@property (strong, nonatomic)UIImage *beacone;
@property (strong, nonatomic)UIButton * temp;
@property (nonatomic) int tag;
@end

@implementation ChangeBeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    _countrybeaconArray = [[NSMutableArray alloc]initWithObjects:@"germany.png",@"brazil.png",@"usa.png",@"france.png",@"australia.png",@"unionjack.png",@"canada.png",@"china.png", nil];
    _colourbeaconArray = [[NSMutableArray alloc]init];
    for(int i=1;i<13;i++){
        
        UIImage *colourBeacon = [UIImage imageNamed:[NSString stringWithFormat:@"colourBeacon%d.png",i]];
        [_colourbeaconArray addObject:colourBeacon];
    }
    // Do any additional setup after loading the view.
    
    self.applybutton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    CGFloat colourBeaconviewWidth = self.colourBeaconView.frame.size.width;
    CGFloat colourBeaconviewHeight = self.colourBeaconView.frame.size.height;
    
    CGFloat beaconImageWith = self.colourBeaconView.frame.size.width * 207/1242;
    CGFloat beaconImageHeight = beaconImageWith;
    
     //place colour beacons in ColourBeacon View
    
    for(int i = 0; i<3; i++){
        
        for(int j=0;j<4; j++){
            
            UIButton *colourBeacon = [[UIButton alloc]initWithFrame:CGRectMake( (j + 1) * (colourBeaconviewWidth - beaconImageWith * 4)/5 + j * beaconImageWith, (i * beaconImageHeight + i * (colourBeaconviewHeight - beaconImageHeight * 3)/2), beaconImageWith, beaconImageHeight)];
            UIImage *clours = [_colourbeaconArray objectAtIndex:j + i*4];
            [colourBeacon setTag:j + i*4 ];
            [colourBeacon setImage:clours forState:UIControlStateNormal];
            [colourBeacon addTarget:self action:@selector(colourBeaconButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.colourBeaconView addSubview:colourBeacon];
        }
    }
    
}

-(void)colourBeaconButtonPressed:(UIButton *)sender{
    _temp.layer.borderWidth = 0;
    sender.layer.cornerRadius = sender.frame.size.width * 1/2;
    sender.layer.borderColor = [[UIColor blackColor]CGColor];
    sender.layer.borderWidth = 2.0;
    _beacone = sender.currentImage;
    _temp = sender;
    _tag = sender.tag;
}

- (IBAction)applySelectedColor:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setInteger:_tag forKey:@"statusIndex"];
}

- (IBAction)backButtonPressed:(id)sender {
    
    MainViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    [[self navigationController]popViewControllerAnimated:viewController];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}
@end
