//
//  WebViewController.h
//  Event Finder
//
//  Created by Adrian on 9/9/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong)NSString *urlString;
@end
