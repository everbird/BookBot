//
//  BBDetailData.m
//  BookBot
//
//  Created by mockee on 12/26/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDetailData.h"

@implementation BBDetailData

- (id)initWithTitle:(NSString *)title author:(NSString *)author summary:(NSString *)summary fullCover:(UIImage *)fullCover {
    if ((self = [super init])) {
        self.title = title;
        self.author = author;
        self.summary = summary;
        self.fullCover = fullCover;
    }
    return self;
}

@end
