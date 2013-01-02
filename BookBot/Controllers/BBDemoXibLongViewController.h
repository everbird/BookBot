//
//  BBDemoXibLongViewController.h
//  BookBot
//
//  Created by everbird on 1/2/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBXibLongViewController.h"

@interface BBDemoXibLongViewController : UIViewController

@property (nonatomic, strong) BBXibLongViewController* xibVC;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
