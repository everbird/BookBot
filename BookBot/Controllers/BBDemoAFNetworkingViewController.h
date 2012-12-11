//
//  BBDemoAFNetworkingViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDemoAFNetworkingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *fetchButton;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

- (IBAction)doFetch:(id)sender;

@end
