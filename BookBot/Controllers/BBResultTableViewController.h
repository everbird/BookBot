//
//  BBResultTableViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBResultTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *detailArray;
@property (copy, nonatomic) NSString* searchText;
@property (strong, nonatomic) NSMutableArray* resultData;
@property (readwrite, assign) NSInteger resultTotal;

@end
