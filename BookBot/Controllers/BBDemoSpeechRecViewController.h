//
//  BBDemoSpeechRecViewController.h
//  BookBot
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZZLevelMeter.h"
#import "ZZAudioRecorder.h"
#import "ZZAudioRecorderDelegate.h"

@interface BBDemoSpeechRecViewController : UIViewController <ZZAudioRecorderDelegate> {
    NSURL* _recordedFile;
    BOOL _isRecording;
    ZZAudioRecorder* _recorder;
}

@property (weak, nonatomic) IBOutlet ZZLevelMeter *levelMeterBar;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *recButton;

- (IBAction)doRec:(id)sender;

@end
