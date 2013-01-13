//
//  BBViewController.h
//  BookBot
//
//  Created by everbird on 12/11/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZZAudioRecorder.h"
#import "ZZAudioRecorderDelegate.h"

#import "BBCoverViewController.h"

@interface BBViewController : UIViewController <ZZAudioRecorderDelegate>
{
    NSMutableArray *searchHistory;
    NSArray *matchedHistory;
    BBCoverViewController* _coverVC;
    ZZAudioRecorder* _recorder;
}

@property (nonatomic, strong) IBOutlet UISearchDisplayController *uiSearchDisplayController;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIButton *speechButton;

- (IBAction)startRecording:(id)sender;
- (IBAction)stopRecording:(id)sender;

@end
