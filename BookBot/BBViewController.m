//
//  BBViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBViewController.h"

#import "BBResultTableViewController.h"


@interface BBViewController ()

@end

@implementation BBViewController

@synthesize searchDisplayController;
@synthesize searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBResultTableViewController* dest = [segue destinationViewController];
    dest.searchText = searchBar.searchBar.text;
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
    searchDisplayController.searchBar.text = cell.textLabel.text;
    //TODO: do search
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search text change: %@", searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
    NSLog(@"search button clicked");
    //TODO: do search
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

@end
