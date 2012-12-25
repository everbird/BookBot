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

@end

@implementation BBResultTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = _searchText;
    _resultData = [[NSMutableArray alloc] init];
    
    [self doSearch:_searchText start:0];
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
        dest.itemText = resultCell.titleLabel.text;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int currCnt = [_resultData count];
    if (currCnt == 0)
    {
        return 1;
    }
    else if (currCnt < _resultTotal)
    {
        return currCnt + 1;
    }
    return currCnt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (_resultTotal == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"No Result";
		return cell;
    }
     */

    if (indexPath.row == [_resultData count])
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"Load More";
        return cell;
    }
    
    static NSString *reuseIdentifier = @"BBBookResultCell";
    BBBookResultCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[BBBookResultCell alloc] init];
    }
    NSDictionary *book = [_resultData objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [book objectForKey:@"title"];
    cell.authorLabel.text = [[book objectForKey:@"author"] componentsJoinedByString:@", "];
    cell.descLabel.text = [book objectForKey:@"summary"];
    [cell.descLabel sizeToFit];
    [cell.coverImage setImageWithURL:[NSURL URLWithString:[book objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Default.png"]];

    return cell;
}

#pragma mark - Private

- (void)doSearch:(NSString*)searchText start:(int) startIndex
{
    NSString *apiString = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&start=%d&apikey=07d7b27cc7c0ea1b178717765742be51", searchText, startIndex];
    NSURL *url = [[NSURL alloc] initWithString:apiString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSDictionary *r = JSON;
        _resultTotal = [[r objectForKey:@"total"] intValue];
        [_resultData addObjectsFromArray:[r objectForKey:@"books"]];
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_resultData count])
    {
        return 44;
    }
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_resultData count]) {
        [self doSearch:_searchText start:[_resultData count]];
    }
}

@end
