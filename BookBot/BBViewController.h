//
//  BBViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBCoverViewController.h"

@interface BBViewController : UIViewController
{
    NSMutableArray *searchHistory;
    NSArray *matchedHistory;
    BBCoverViewController* _coverVC;
}

@property (nonatomic, strong) IBOutlet UISearchDisplayController *uiSearchDisplayController;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end
