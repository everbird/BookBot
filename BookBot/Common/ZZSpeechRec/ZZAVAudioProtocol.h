//
//  ZZAVAudioProtocol.h
//  EXP_SpeachTest001
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZAVAudioProtocol <NSObject>

@property(readonly) NSUInteger numberOfChannels;
@property(getter=isMeteringEnabled) BOOL meteringEnabled; /* turns level metering on or off. default is off. */

- (void)updateMeters; /* call to refresh meter values */

- (float)peakPowerForChannel:(NSUInteger)channelNumber; /* returns peak power in decibels for a given channel */
- (float)averagePowerForChannel:(NSUInteger)channelNumber; /* returns average power in decibels for a given channel */

@end
