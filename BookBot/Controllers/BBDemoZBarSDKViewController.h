//
//  BBDemoZBarSDKViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ZBarSDK/ZBarSDK.h>

@interface BBDemoZBarSDKViewController : UIViewController <ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultISBNLabel;

- (IBAction)doScan:(id)sender;

@end
