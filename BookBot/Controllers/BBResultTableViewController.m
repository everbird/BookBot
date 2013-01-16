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
#import "BBDetailData.h"


@interface BBResultTableViewController ()
{
    UITableViewCell *assitCell;
}

@end

@implementation BBResultTableViewController

- (UITableViewCell *)getAssitCell
{
    if (assitCell == nil)
    {
        assitCell = [[UITableViewCell alloc] init];
        assitCell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    assitCell.hidden = _resultTotal < 0;
    return assitCell;
}

- (UITableViewCell *)getNoResultCell
{
    UITableViewCell *noResultCell = [self getAssitCell];
    noResultCell.selectionStyle = UITableViewCellSelectionStyleNone;
    noResultCell.textLabel.text = @"No Result";
    return noResultCell;
}

- (UITableViewCell *)getLoadMoreCell
{
    UITableViewCell *loadMoreCell = [self getAssitCell];
    loadMoreCell.textLabel.text = @"Load More";
    return loadMoreCell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = _searchText;
    _resultData = [[NSMutableArray alloc] init];
    _resultTotal = -1;
    
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
        BBDetailViewController *detailController = [segue destinationViewController];
        BBBookResultCell *resultCell = (BBBookResultCell*)sender;
        
        NSString *title = resultCell.titleLabel.text;
        NSString *author = resultCell.authorLabel.text;
        NSString *summary= resultCell.descLabel.text;
        NSURL *fullCoverUrl = resultCell.fullCoverUrl;
        BBDetailData *detail = [[BBDetailData alloc] init];
        
        detail.title = title;
        detail.author = author;
        detail.summary = summary;
        detail.fullCoverUrl = fullCoverUrl;
        
        detailController.xibVC.detailItem = detail;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int currentResultCount = [_resultData count];
    if (currentResultCount == 0)
    {
        return 1;
    }
    else if (currentResultCount < _resultTotal)
    {
        return currentResultCount + 1;
    }
    return currentResultCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_resultTotal == 0)
    {
        return [self getNoResultCell];
    }

    if (indexPath.row == [_resultData count])
    {
        return [self getLoadMoreCell];
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
    
    NSURL *fullCoverUrl = [NSURL URLWithString:[[book objectForKey:@"images"] objectForKey:(@"large")]];
    cell.fullCoverUrl = fullCoverUrl;
    
    [cell.coverImage setImageWithURL:[NSURL URLWithString:[book objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Default.png"]];

    [cell.descLabel sizeToFit];
    return cell;
}

#pragma mark - Private

- (void)doSearch:(NSString*)searchText start:(int) startIndex
{
    NSString *apiString = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&start=%d&apikey=07d7b27cc7c0ea1b178717765742be51", [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], startIndex];
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
    return (indexPath.row == [_resultData count])? 44 : 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_resultData count] == 0)
    {
        return;
    }
    if (indexPath.row == [_resultData count])
    {
        [self doSearch:_searchText start:[_resultData count]];
    }
}

@end
