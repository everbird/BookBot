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
    UISearchDisplayController *searchDisplayController;
    UISearchDisplayController *searchBar;
    NSArray *searchHistory;
    NSArray *matchedHistory;
}

@property (nonatomic, retain) IBOutlet UISearchDisplayController *searchDisplayController;
@property (nonatomic, retain) IBOutlet UISearchDisplayController *searchBar;

@end
