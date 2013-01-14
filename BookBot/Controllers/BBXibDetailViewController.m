//
//  BBXibDetailViewController.m
//  BookBot
//
//  Created by mockee on 1/14/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//


#import "BBXibDetailViewController.h"

@interface BBXibDetailViewController ()
- (void)configureView;
@end

@implementation BBXibDetailViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.navigationItem.title = @"详细信息";
    if (self.detailItem) {
        self.titleField.text = self.detailItem.title;
        self.authorsLabel.text = self.detailItem.author;
        self.introView.text = self.detailItem.summary;
        self.coverView.image = self.detailItem.fullCover;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setCoverView:nil];
    [self setTitleField:nil];
    [self setAuthorsLabel:nil];
    [self setIntroView:nil];
    [super viewDidUnload];
}
@end
