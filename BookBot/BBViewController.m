//
//  BBViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <JSONKit/JSONKit.h>

#import "BBViewController.h"
#import "BBResultTableViewController.h"


@interface BBViewController ()

@end

@implementation BBViewController

//@synthesize searchDisplayController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    //TODO: get search history
    NSArray *mockHistory = @[
        @"Apple",
        @"Google",
        @"Amazon",
        @"Facebook",
        @"Twitter",
        @"Yahoo",
        @"java",
        @"javascript",
        @"python",
        @"objective-c",
    ];
    searchHistory = mockHistory;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        rows = [matchedHistory count];
    }
    else
    {
        rows = [searchHistory count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        cell.textLabel.text = [matchedHistory objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [searchHistory objectAtIndex:indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _searchBar.text = cell.textLabel.text;
    [self searchBarSearchButtonClicked:_searchBar];
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search text change: %@", searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
    
    NSString *apiString = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&apikey=07d7b27cc7c0ea1b178717765742be51", aSearchBar.text];
    NSURL *url = [[NSURL alloc] initWithString:apiString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        //NSLog(@"%@", JSON);
        NSDictionary *r = JSON;
        NSArray *books = [r objectForKey:@"books"];
        
        NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:[books count]];
        for (NSDictionary *book in books)
        {
            [titles addObject:[book objectForKey:@"title"]];
        }
        
        BBResultTableViewController *controller = [[BBResultTableViewController alloc] init];
        controller.searchText = aSearchBar.text;
        controller.resultData = titles;
        UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:controller];
        [self presentModalViewController:navController animated:YES];
                                             
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}

- (IBAction)doFetch:(NSString *)query
{

}

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    matchedHistory = [searchHistory filteredArrayUsingPredicate:resultPredicate];
}


#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    return YES;
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}
@end
