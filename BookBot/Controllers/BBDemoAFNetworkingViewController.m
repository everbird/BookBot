//
//  BBDemoAFNetworkingViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDemoAFNetworkingViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <JSONKit/JSONKit.h>

@interface BBDemoAFNetworkingViewController ()

@end

@implementation BBDemoAFNetworkingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)doFetch:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"https://api.douban.com/v2/book/isbn/9781593273880?apikey=07d7b27cc7c0ea1b178717765742be51"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        NSDictionary* r = JSON;
        _resultTextView.text = [r JSONString];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}
@end
