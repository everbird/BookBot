//
//  BBBookResultCell.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBBookResultCell : UITableViewCell

@property (copy, nonatomic) NSString* itemText;

- (void)refreshUI;

@end
