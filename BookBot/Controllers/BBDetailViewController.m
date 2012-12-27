//
//  BBDetailViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDetailViewController.h"

@interface BBDetailViewController ()
- (void)configureView;
@end

@implementation BBDetailViewController

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
    self.navigationItem.title = self.detailItem.title;
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
