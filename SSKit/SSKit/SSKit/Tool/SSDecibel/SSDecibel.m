//
//  SSDecibel.m
//  SSKit
//
//  Created by 孙铭健 on 2020/11/2.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSDecibel.h"

#import <AVFoundation/AVFoundation.h>

@interface SSDecibel ()

//** 录音机 **//
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SSDecibel

- (void)openRecord:(void(^)(NSUInteger db))updatePower
{
    [self configAudioRecorder];
    
    if (!_audioRecorder.isRecording) {
        [_audioRecorder record];
        
        __weak typeof(self) selfWeak = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof(selfWeak) self = selfWeak;
            
            [self.audioRecorder updateMeters];
            float power = [self.audioRecorder averagePowerForChannel:0];
            //***********有待优化**********//
            NSLog(@"-----  %.1lf", power);
//            power = (power + 160) * 0.75/10; // [0, 120]
            power = 20 * log10(5 * powf(10, (power/20))) + 50;
            NSLog(@"=====  %.1lf", power);
            //***********有待优化**********//
            if (updatePower) {
                updatePower(power);
            }
        }];
        
    }
}

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

@end
