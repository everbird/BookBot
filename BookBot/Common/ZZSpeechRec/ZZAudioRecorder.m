//
//  BBAudioRecoder.m
//  EXP_SpeachTest001
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "ZZAudioRecorder.h"


#define SAMPLE_RATE 16000
#define SILENCE_DELAY   2
#define PEAKPOWER_THRESHOLDER   -10.0

NSString* const kRecordedFile = @"recorded.caf";

@implementation ZZAudioRecorder

- (id)initWithDest:(NSString*)dest
{
    NSDictionary* settings = @{
        AVSampleRateKey: [NSNumber numberWithInt: SAMPLE_RATE],
        AVNumberOfChannelsKey: @2,
        };
    _recordedFile = [NSTemporaryDirectory() stringByAppendingString:kRecordedFile];
    
    if ([self initWithURL:[NSURL fileURLWithPath:_recordedFile] settings:settings error:nil]) {
        
    }
    
    return self;
}

- (void)startRecording
{
    [self prepareToRecord];
    [self record];
    [self startMonitor];
    
    if ([_recDelegate respondsToSelector:@selector(afterStartRecording)]) {
        [_recDelegate performSelector:@selector(afterStartRecording)];
    }
}

- (void)finishRecording
{
    [self resetMonitor];
    [self stop];
    
    if ([_recDelegate respondsToSelector:@selector(afterFinishRecording)]) {
        [_recDelegate performSelector:@selector(afterFinishRecording)];
    }
}

- (NSUInteger) numberOfChannels
{
    return 2;
}

- (void)startMonitor
{
    _silenceTime = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(refresh)
                                            userInfo:nil repeats:YES];
}

- (void)resetMonitor
{
    [_timer invalidate];
    _timer = nil;
}

- (void)refresh
{
    if ([self peakPowerForChannel:0] < PEAKPOWER_THRESHOLDER) {
        _silenceTime += 0.1;
    }
    
    if (_silenceTime > SILENCE_DELAY) {
        
        [self finishRecording];
        
        if ([_recDelegate respondsToSelector:@selector(finishWhenSilenceDetected)]) {
            [_recDelegate performSelector:@selector(finishWhenSilenceDetected)];
        }
        
    }
}

@end
