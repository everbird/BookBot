//
//  BBDemoXibLongViewController.m
//  BookBot
//
//  Created by everbird on 1/2/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import "BBDemoXibLongViewController.h"

@interface BBDemoXibLongViewController ()

@end

@implementation BBDemoXibLongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _xibVC = [[BBXibLongViewController alloc] initWithNibName:@"BBXibLongViewController" bundle:nil];
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
