//
//  ZZAudioRecorderDelegate.h
//  EXP_SpeachTest001
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZAudioRecorderDelegate <NSObject>

@optional
- (void)afterStartRecording;
- (void)afterFinishRecording;
- (void)finishWhenSilenceDetected;

@end
