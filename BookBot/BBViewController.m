//
//  BBViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBViewController.h"

#import "BBResultTableViewController.h"
#import "AppCommon.h"

#import <AFNetworking/AFNetworking.h>
#import <FTUtils/FTUtils.h>
#import <JSONKit/JSONKit.h>
#import "BBStoreViewController.h"

@interface BBViewController ()
{
    UIAlertView *alert;
}
@end

@implementation BBViewController

//@synthesize searchDisplayController;

- (NSString *)getPlistLocation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *location = [directory stringByAppendingString:@"/search_history.plist"];
    return location;
}

- (void)saveHistory
{
    [searchHistory writeToFile:[self getPlistLocation] atomically:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self getPlistLocation]];
    searchHistory = [[NSMutableArray alloc] initWithArray:array];
    
    _coverVC = [[BBCoverViewController alloc] initWithNibName:@"BBCoverViewController" bundle:nil];
    _coverVC.shown = NO;
    
    [_speechButton addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchDown];
    [_speechButton addTarget:self action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    
    alert = [[UIAlertView alloc] initWithTitle:@"语音识别"
                                                    message:@"语音未识别，请再次尝试"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(textFieldResign)];
    tapRecognizer.numberOfTapsRequired = 1;;
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer: tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    if (!_coverVC.shown) {
        _coverVC.view.frame = self.view.bounds;
        [self.view addSubview:_coverVC.view];
        [self.view bringSubviewToFront:_coverVC.view];
        _coverVC.shown = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBResultTableViewController* dest = [segue destinationViewController];
    dest.searchText = _searchBar.text;
    if(![searchHistory containsObject:dest.searchText])
    {
        [searchHistory addObject:dest.searchText];
    }
    [self saveHistory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_coverVC logoMove];
}

- (IBAction)startRecording:(id)sender
{
    _recorder = [[ZZAudioRecorder alloc] initWithDest:AV_DEST_FILE];
    _recorder.recDelegate = self;
    [_recorder startRecording];
}

- (IBAction)stopRecording:(id)sender
{
    if (_recorder.isRecording)
    {
        [_recorder finishRecording];
    }
    _recorder = nil;
}

- (void)recognize:(NSString*)dest
{
    NSString* filename = dest;
    NSString *filePathDest = [NSTemporaryDirectory() stringByAppendingString:filename];
    NSData* flacData = [[NSFileManager defaultManager] contentsAtPath:filePathDest];
    AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.google.com/"]];
    NSDictionary* sendDict = @{
    @"name": [filename dataUsingEncoding:NSUTF8StringEncoding],
    };
    NSMutableURLRequest* request = [client multipartFormRequestWithMethod:@"POST" path:GOOGLE_AUDIO_URL parameters:sendDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:flacData name:filename];
    }];
    
    [request setValue:@"audio/x-flac; rate=16000" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* resultDict = [(NSData*)responseObject objectFromJSONData];
        NSLog(@">>> success: %@", resultDict);
        NSArray* hypotheses = [resultDict objectForKey:@"hypotheses"];
        if (hypotheses.count)
        {
            NSDictionary* result = [hypotheses objectAtIndex:0];
            _searchBar.text = [result objectForKey:@"utterance"];
            [_searchBar becomeFirstResponder];
        }
        else
        {
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@">>> failure: %@", error);
    }];
    
    [client enqueueHTTPRequestOperation:operation];
}

- (void)convertFrom:(NSString*)src to:(NSString*)dest
{
    const char *pFilePath = [src UTF8String];
    FILE *infile;
    long fileread;
    
    infile = fopen(pFilePath,"r");
    fseek(infile, 0, SEEK_END);
    fileread = ftell(infile);
    fclose(infile);
    
    startEncode(pFilePath, [dest UTF8String], fileread);
}

- (void)afterFinishRecording
{
    [self convertFrom:_recorder.recordedFile to:[NSTemporaryDirectory() stringByAppendingString:AV_DEST_FILE]];
    [self recognize: AV_DEST_FILE];
}

- (void)finishWhenSilenceDetected
{
    [_recorder finishRecording];
    _recorder = nil;
}

#pragma mark - UITableViewController delegate methods

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"SearchToResult" sender:cell];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"SearchToResult" sender:self];
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
    [self setSpeechButton:nil];
    [self setScanButton:nil];
    [self setOpenStore:nil];
    [super viewDidUnload];
}

#pragma mark - Actions

- (IBAction)doScan:(id)sender {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25
				   config: ZBAR_CFG_ENABLE
					   to: 0];
    [self presentViewController:reader animated:YES completion:^{
        // Do nothing        
    }];
}

# pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results) {
        break;
    }
    NSLog(@"===%@",symbol.data);
    NSString* isbn = symbol.data;
    [reader dismissViewControllerAnimated:YES completion:^{
        // Do nothing
        NSLog(@"isbn is %@", isbn);
        _searchBar.text = isbn;
        [self performSegueWithIdentifier:@"SearchToResult" sender:nil];
    }];
}

- (void)textFieldResign
{
    [_searchBar resignFirstResponder];
}

- (IBAction)doOpenStore:(id)sender {
    BBStoreViewController* webVC = [[BBStoreViewController alloc] initWithNibName:@"BBStoreViewController" bundle:nil];
    [self presentModalViewController:webVC animated:YES];
}
@end
