//
//  BBStoreViewController.m
//  BookBot
//
//  Created by everbird on 1/25/13.
//  Copyright (c) 2013 Douban.com Inc. All rights reserved.
//

#import "BBStoreViewController.h"

@interface BBStoreViewController ()

@end

@implementation BBStoreViewController

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
    
    NSURL *url =[NSURL URLWithString:@"http://read.douban.com"];
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

- (IBAction)doDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
