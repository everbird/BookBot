//
//  BBCoverViewController.h
//  BookBot
//
//  Created by everbird on 1/2/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCoverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic) BOOL shown;

- (void)logoMove;

@end
