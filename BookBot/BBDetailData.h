//
//  BBDetailData.h
//  BookBot
//
//  Created by mockee on 12/26/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDetailData : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSURL *fullCoverUrl;

- (id)initWithTitle:(NSString *)title author:(NSString *)author summary:(NSString *)summary fullCoverUrl:(NSURL *)fullCoverUrl;

@end
