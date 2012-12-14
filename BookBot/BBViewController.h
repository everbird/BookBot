//
//  BBViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBViewController : UIViewController
{
    NSArray *searchHistory;
    NSArray *matchedHistory;
}

@property (nonatomic, strong) IBOutlet UISearchDisplayController *uiSearchDisplayController;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;


@end
