//
//  TermsViewController.m
//  Event Finder
//
//  Created by Adrian on 9/6/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.body.layer.masksToBounds = YES;
    self.body.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [[self navigationController]popViewControllerAnimated:YES];
}


@end
