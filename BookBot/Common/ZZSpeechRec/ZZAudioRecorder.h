//
//  BBAudioRecoder.h
//  EXP_SpeachTest001
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ZZAVAudioProtocol.h"
#import "ZZAudioRecorderDelegate.h"

@interface ZZAudioRecorder : AVAudioRecorder <ZZAVAudioProtocol> {
    double _silenceTime;
    BOOL _isDetectedVoice;
}

@property (nonatomic, copy) NSString* recordedFile;
@property (nonatomic, copy) NSString* destFile;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, weak) id<ZZAudioRecorderDelegate> recDelegate;

- (id)initWithDest:(NSString*)dest;
- (void)startRecording;
- (void)finishRecording;

@end
