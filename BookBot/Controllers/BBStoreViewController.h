//
//  BBStoreViewController.h
//  BookBot
//
//  Created by everbird on 1/25/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBStoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)doDismiss:(id)sender;

@end
