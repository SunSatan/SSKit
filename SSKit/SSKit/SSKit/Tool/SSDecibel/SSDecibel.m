//
//  SSDecibel.m
//  SSKit
//
//  Created by SunSatan on 2020/11/2.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDecibel.h"

#import <AVFoundation/AVFoundation.h>

@interface SSDecibel ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder; //** 录音机 **//
@property (nonatomic, strong) NSMutableArray<NSNumber *> *records; //** 记录 **//

@end

@implementation SSDecibel

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"SSDecibel -> dealloc");
    [self endCheckDecibel];
}

#pragma mark - 配置

- (void)configAudioRecorder
{
    if (_audioRecorder) return;
    
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = @{AVSampleRateKey:@(8000),
                               AVNumberOfChannelsKey:@(2),
                               AVLinearPCMBitDepthKey:@(8),
                               AVEncoderAudioQualityKey:@(AVAudioQualityHigh),
                               AVFormatIDKey:@(kAudioFormatAppleLossless),
                               AVLinearPCMIsFloatKey:@(NO)
    };
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:nil];
    _audioRecorder.meteringEnabled = YES;
}

#pragma mark - 开始

- (void)startCheckDecibelWithInterval:(NSTimeInterval)interval
                        updateDecibel:(void(^)(NSUInteger db))updateDecibel;
{
    [self configAudioRecorder];
    
    if (!_audioRecorder.isRecording) {
        [_audioRecorder record];
        _records = NSMutableArray.new;
        __weak typeof(self) selfWeak = self;
        _timer = [NSTimer timerWithTimeInterval:interval repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof(selfWeak) self = selfWeak;
            
            [self.audioRecorder updateMeters];
            float db = [self.audioRecorder averagePowerForChannel:0];
            //***********有待优化**********//
            NSLog(@"-----  %.1lf", db);
//            power = (power + 160) * 0.75/10; // [0, 120]
            db = 20 * log10(5 * powf(10, (db/20))) + 50;
            [self.records addObject:@(db)];
            NSLog(@"=====  %.1lf", db);
            //***********有待优化**********//
            if (updateDecibel) updateDecibel(db);
        }];
        [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)endCheckDecibel
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - getter

- (NSArray *)dbRecords
{
    return [NSArray arrayWithArray:_records];
}

-(NSUInteger)avgDB
{
    NSUInteger avg = 0;
    for (NSNumber *element in _records) {
        NSInteger db = element.integerValue;
        avg += db;
    }
    avg /= _records.count;
    return avg;
}

- (NSUInteger)maxDB
{
    NSUInteger max = _records.firstObject.integerValue;
    for (NSNumber *element in _records) {
        NSInteger db = element.integerValue;
        if (db > max)  max = db;
    }
    return max;
}

- (NSUInteger)minDB
{
    NSUInteger min = _records.firstObject.integerValue;
    for (NSNumber *element in _records) {
        NSInteger db = element.integerValue;
        if (db < min)  min = db;
    }
    return min;
}

@end
