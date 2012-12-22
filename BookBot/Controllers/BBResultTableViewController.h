//
//  BBResultTableViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBResultTableViewController : UITableViewController

@property (copy, nonatomic) NSString* searchText;
@property (strong, nonatomic) NSMutableArray* resultData;

@end
