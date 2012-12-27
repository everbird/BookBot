//
//  BBDetailViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDetailData.h"

@class BBDetailData;

@interface BBDetailViewController : UIViewController

@property (strong, nonatomic) BBDetailData  *detailItem;
@property (copy, nonatomic) NSString *itemText;
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (strong, nonatomic) IBOutlet UILabel *titleField;
@property (strong, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UITextView *introView;

@end