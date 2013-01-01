//
//  BBDemoSpeechRecViewController.m
//  BookBot
//
//  Created by everbird on 12/31/12.
//  Copyright (c) 2012 Douban.com Inc. All rights reserved.
//

#import "BBDemoSpeechRecViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <JSONKit/JSONKit.h>

#import "AppCommon.h"

#include "../Common/ZZSpeechRec/flac_encoder.c"

@interface BBDemoSpeechRecViewController ()

@end

@implementation BBDemoSpeechRecViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setLevelMeterBar:nil];
    [self setResultLabel:nil];
    [self setRecButton:nil];
    [super viewDidUnload];
}

- (IBAction)doRec:(id)sender {
    if (!_isRecording) {
        _isRecording = YES;
        [_recButton setTitle:@"STOP" forState:UIControlStateNormal];
        _recorder = [[ZZAudioRecorder alloc] initWithDest:AV_DEST_FILE];
        _recorder.recDelegate = self;
        _levelMeterBar.player = _recorder;
        [_recorder startRecording];
    } else {
        _isRecording = NO;
        [_recButton setTitle:@"REC" forState:UIControlStateNormal];
        _levelMeterBar.player = nil;
        [_recorder finishRecording];
        _recorder = nil;
    }
}

- (void)recognize:(NSString*)dest
{
    NSString* filename = dest;
    NSString *filePathDest = [NSTemporaryDirectory() stringByAppendingString:filename];
    NSData* flacData = [[NSFileManager defaultManager] contentsAtPath:filePathDest];
    AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.google.com/"]];
    NSDictionary* sendDict = @{
    @"name": [filename dataUsingEncoding:NSUTF8StringEncoding],
    };
    NSMutableURLRequest* request = [client multipartFormRequestWithMethod:@"POST" path:GOOGLE_AUDIO_URL parameters:sendDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:flacData name:filename];
    }];
    
    [request setValue:@"audio/x-flac; rate=16000" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSDictionary* resultDict = [(NSData*)responseObject objectFromJSONData];
        NSLog(@">>> success: %@", resultDict);
        NSArray* hypotheses = [resultDict objectForKey:@"hypotheses"];
        if (hypotheses && [hypotheses count]>0) {
            NSDictionary* result = [hypotheses objectAtIndex:0];
            _resultLabel.text = [result objectForKey:@"utterance"];
        } else {
            _resultLabel.text = @"<未识别>";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@">>> failure: %@", error);
    }];
    
    [client enqueueHTTPRequestOperation:operation];
}

- (void)convertFrom:(NSString*)src to:(NSString*)dest
{
    const char *pFilePath = [src UTF8String];
    FILE *infile;
    long fileread;
    
    infile = fopen(pFilePath,"r");
    fseek(infile, 0, SEEK_END);
    fileread = ftell(infile);
    fclose(infile);
    
    startEncode(pFilePath, [dest UTF8String], fileread);
}

- (void)afterFinishRecording
{
    [self convertFrom:_recorder.recordedFile to:[NSTemporaryDirectory() stringByAppendingString:AV_DEST_FILE]];
    [self recognize: AV_DEST_FILE];
}

- (void)finishWhenSilenceDetected
{
    _isRecording = NO;
    [_recButton setTitle:@"REC" forState:UIControlStateNormal];
    _levelMeterBar.player = nil;
    [_recorder finishRecording];
    _recorder = nil;
}

@end
