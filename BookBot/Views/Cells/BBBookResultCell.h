//
//  BBBookResultCell.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBBookResultCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *mCover;
@property (strong, nonatomic) IBOutlet UILabel *mTitle;
@property (strong, nonatomic) IBOutlet UILabel *mAuthor;
@property (strong, nonatomic) IBOutlet UILabel *mDesc;

- (void)refreshUI;

@end
