//
//  BBResultTableViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBResultTableViewController.h"

#import <JSONKit/JSONKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "BBBookResultCell.h"
#import "BBDetailViewController.h"
#import "AppCommon.h"


@interface BBResultTableViewController ()

- (void)doSearch:(NSString*)searchText;

@end

@implementation BBResultTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = _searchText;
    
    [self doSearch:_searchText];
}

- (void)backToSearch{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (ISINSTANCE(sender, BBBookResultCell)) {
        BBBookResultCell* resultCell = (BBBookResultCell*)sender;
        BBDetailViewController* dest = [segue destinationViewController];
        dest.itemText = resultCell.textLabel.text;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_resultData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"BBBookResultCell";
    BBBookResultCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[BBBookResultCell alloc] init];
    }
    NSDictionary *book = [_resultData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [book objectForKey:@"title"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:[book objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Default.png"]];
    [cell refreshUI];
    return cell;
}

#pragma mark - Private

- (void)doSearch:(NSString*)searchText
{
    NSString *apiString = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&apikey=07d7b27cc7c0ea1b178717765742be51", searchText];
    NSURL *url = [[NSURL alloc] initWithString:apiString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSDictionary *r = JSON;
        NSArray *books = [r objectForKey:@"books"];
        
        _resultData = [[NSMutableArray alloc] initWithCapacity:[books count]];
        
        for (NSDictionary *book in books)
        {
            [_resultData addObject:book];
        }
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

@end
