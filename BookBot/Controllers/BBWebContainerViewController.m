//
//  BBWebContainerViewController.m
//  BookBot
//
//  Created by everbird on 1/25/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import "BBWebContainerViewController.h"

@interface BBWebContainerViewController ()

@end

@implementation BBWebContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url =[NSURL URLWithString:@"http://read.douban.com/reader/ebook/407582/"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
}

- (IBAction)doBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
