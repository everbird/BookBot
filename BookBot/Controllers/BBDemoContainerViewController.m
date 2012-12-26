//
//  BBDemoContainerViewController.m
//  BookBot
//
//  Created by everbird on 12/26/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDemoContainerViewController.h"

@interface BBDemoContainerViewController ()

@end

@implementation BBDemoContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scorllView.contentSize = _containerView.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setScorllView:nil];
    [self setContainerView:nil];
    [super viewDidUnload];
}

@end
