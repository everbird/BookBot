//
//  BBDetailData.h
//  BookBot
//
//  Created by mockee on 12/26/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDetailData : NSObject

@property (strong) NSString *title;
@property (strong) NSString *author;
@property (strong) NSString *summary;
@property (strong) UIImage *fullCover;

- (id)initWithTitle:(NSString *)title author:(NSString *)author summary:(NSString *)summary fullCover:(UIImage *)fullCover;

@end
