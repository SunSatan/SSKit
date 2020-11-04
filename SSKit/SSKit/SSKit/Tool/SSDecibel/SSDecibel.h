//
//  SSDecibel.h
//  SSKit
//
//  Created by 孙铭健 on 2020/11/2.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// SPL = 20 * log10[p(e)/p(ref)]
// p(e)为待测的有效声压，p(ref)为参考声压，一般取2*10E-5帕，这是人耳能分辨的最小声压（1KHz）。
// SPL = 20 * log10(referenceLevel * powf(10, (averagePowerForChannel/20)) * range) + offset;
// referenceLevel = 5，range = 160，offset = 50

@interface SSDecibel : NSObject

- (void)openRecord:(void(^)(NSUInteger db))updatePower;

@end

NS_ASSUME_NONNULL_END
