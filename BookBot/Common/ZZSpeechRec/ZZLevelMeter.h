//
//  ZZLevelMeter.h
//  EXP_SpeachTest001
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioQueue.h>
#import <AVFoundation/AVFoundation.h>

#include "MeterTable.h"
#import "ZZAVAudioProtocol.h"

#define kPeakFalloffPerSec	.7
#define kLevelFalloffPerSec .8
#define kMinDBvalue -80.0

@interface ZZLevelMeter : UIView {
    id<ZZAVAudioProtocol>				_player;
	NSArray						*_channelNumbers;
	NSArray						*_subLevelMeters;
	MeterTable					*_meterTable;
	CADisplayLink				*_updateTimer;
	BOOL						_showsPeaks;
	BOOL						_vertical;
	BOOL						_useGL;
	
	CFAbsoluteTime				_peakFalloffLastFire;;
}

- (void)setPlayer:(id<ZZAVAudioProtocol>)v;

@property (readonly)	id<ZZAVAudioProtocol> player; // The AVAudioPlayer object
@property (retain)		NSArray *channelNumbers; // Array of NSNumber objects: The indices of the channels to display in this meter
@property				BOOL showsPeaks; // Whether or not we show peak levels
@property				BOOL vertical; // Whether the view is oriented V or H
@property				BOOL useGL; // Whether or not to use OpenGL for drawing

@end
