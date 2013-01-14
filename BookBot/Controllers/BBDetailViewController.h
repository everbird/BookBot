//
//  BBDetailViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBXibDetailViewController.h"

@interface BBDetailViewController : UIViewController

@property (nonatomic, strong) BBXibDetailViewController *xibVC;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end