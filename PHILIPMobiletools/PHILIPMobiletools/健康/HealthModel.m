//
//  HealthModel.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/5.
//

#import "HealthModel.h"
#import <UIKit/UIKit.h>

@implementation HealthModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _icon  = @"";
        _title = @"";
        _data  = @"";
        _unit  = @"";
        _time  = @"";
    }
    return self;
}



- (NSAttributedString *)healthString
{
    NSDictionary *dataDict = @{NSFontAttributeName:[UIFont fontWithName:@"Trebuchet-BoldItalic" size:28]}; //MarkerFelt-Wide
    NSDictionary *describeDict = @{NSFontAttributeName:[UIFont fontWithName:@"HiraMaruProN-W4" size:16]};
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_title attributes:describeDict];
    
    NSAttributedString *dataStr = [[NSAttributedString alloc] initWithString:_data attributes:dataDict];
    [str appendAttributedString:dataStr];
    
    NSAttributedString *unitStr = [[NSAttributedString alloc] initWithString:_unit attributes:describeDict];
    [str appendAttributedString:unitStr];
    
    return str;
}

@end
