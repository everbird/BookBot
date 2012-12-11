//
//  BBDemoZBarSDKViewController.m
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDemoZBarSDKViewController.h"

@interface BBDemoZBarSDKViewController ()

@end

@implementation BBDemoZBarSDKViewController


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
    _resultISBNLabel.text = symbol.data;
    _resultImageView.image =
	[info objectForKey: UIImagePickerControllerOriginalImage];
    [reader dismissViewControllerAnimated:YES completion:^{
        // Do nothing
    }];
}

@end
