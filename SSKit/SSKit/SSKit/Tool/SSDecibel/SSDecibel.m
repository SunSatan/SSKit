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
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof(selfWeak) self = selfWeak;
            
            [self.audioRecorder updateMeters];
            float power = [self.audioRecorder averagePowerForChannel:0];
            power = power + 160  - 50;
           
            int dB = 0;
            if (power < 0.f) {
                dB = 0;
            } else if (power < 40.f) {
                dB = (int)(power * 0.875);
            } else if (power < 100.f) {
                dB = (int)(power - 15);
            } else if (power < 110.f) {
                dB = (int)(power * 2.5 - 165);
            } else {
                dB = 110;
            }
            
            if (updatePower) {
                updatePower(dB);
            }
        }];
        
    }
}

- (void)configAudioRecorder
{
    if (_audioRecorder) return;
    
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = @{AVSampleRateKey:@(44100),
                               AVNumberOfChannelsKey:@(2),
                               AVLinearPCMBitDepthKey:@(8),
                               AVEncoderAudioQualityKey:@(AVAudioQualityMax),
                               AVFormatIDKey:@(kAudioFormatAppleLossless),
                               AVLinearPCMBitDepthKey:@(8),
                               AVLinearPCMIsFloatKey:@(YES)
    };

    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:nil];
    _audioRecorder.meteringEnabled = YES;
}

@end
