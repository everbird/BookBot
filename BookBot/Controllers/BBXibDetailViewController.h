//
//  BBXibDetailViewController.h
//  BookBot
//
//  Created by mockee on 1/14/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BBDetailData.h"

@class BBDetailData;

@interface BBXibDetailViewController : UIViewController

@property (strong, nonatomic) BBDetailData  *detailItem;
@property (copy, nonatomic) NSString *itemText;
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (strong, nonatomic) IBOutlet UILabel *titleField;
@property (strong, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UITextView *introView;

@end
