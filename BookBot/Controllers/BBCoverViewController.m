//
//  BBCoverViewController.m
//  BookBot
//
//  Created by everbird on 1/2/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import "BBCoverViewController.h"

#import <FTUtils/FTAnimation+UIView.h>

@interface BBCoverViewController ()

@end

@implementation BBCoverViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)logoMove
{
    [UIView animateWithDuration:.4
                     animations:^{
                         CGRect rect = _logoImageView.frame;
                         rect.origin.y = 39;
                         _logoImageView.frame = rect;
                     } completion:^(BOOL finished) {
                        [self.view fadeOut:.4 delegate:self startSelector:nil stopSelector:@selector(afterAnimationStop)];
                     }];
}

- (void)afterAnimationStop
{
    [self.view removeFromSuperview];
    self.view = nil;
}

- (void)viewDidUnload {
    [self setLogoImageView:nil];
    [super viewDidUnload];
}
@end
