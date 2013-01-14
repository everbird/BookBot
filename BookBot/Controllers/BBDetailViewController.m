//
//  BBDetailViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDetailViewController.h"

@interface BBDetailViewController ()

@end

@implementation BBDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _xibVC = [[BBXibDetailViewController alloc] initWithNibName:@"BBXibDetailViewController" bundle:nil];
    [_scrollView addSubview:_xibVC.view];
    _scrollView.contentSize = _xibVC.view.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setXibVC:nil];
    
    [super viewDidUnload];
}

@end