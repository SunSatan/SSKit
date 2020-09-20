//
//  SSIndexBar.m
//
//  Created by SunSatan on 2020/8/31.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSIndexBar.h"
#import "SSIndexTipsView.h"

static CGFloat const kAnimateDuration  = 0.5;
static CGFloat const kDefaultRowHeight = 16;
static CGFloat const kDefaultTextFont  = 11;
static CGFloat const kTipsViewPosition = -80;
static CGFloat const kTipsViewSize     = 60;

@interface SSIndexBar ()

@property (nonatomic, strong) UILabel *preLabel;//记录点击的label
@property (nonatomic, strong) SSIndexTipsView *indexTipsView;
@property (nonatomic, strong) UIImpactFeedbackGenerator *feedBackGenertor API_AVAILABLE(ios(10.0));
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation SSIndexBar

- (void)dealloc
{
    NSLog(@"SSIndexBar -----> dealloc");
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self defaultConfig];
    }
    return self;
}

- (void)layoutSubviews
{
    [self recalculateFrame];
}

#pragma mark - defaultConfig

- (void)defaultConfig
{
    [self configData];
    [self configSwitch];
    [self configStyle];
    [self addIndexTipsView];
    [self prepareFeedBackGenertor];
}

- (void)configData
{
    _selectedIndex = -1;
    _labelArray = [NSMutableArray array];
}

- (void)configSwitch
{
    _canClick       = YES;
    _canSwipe       = YES;
    _animation      = YES;
    _canFeedback    = YES;
    _tipsViewHidden = NO;
}

- (void)configStyle
{
    _rowHeight = kDefaultRowHeight;
    
    _textNormalColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    _textSelectColor = UIColor.whiteColor;
    
    _backgroundNormalColor = UIColor.clearColor;
    _backgroundSelectColor = [UIColor colorWithRed:7/255.0 green:193/255.0 blue:96/255.0 alpha:1];
    
    _textNormalFont = [UIFont boldSystemFontOfSize:kDefaultTextFont];
    _textSelectFont = [UIFont boldSystemFontOfSize:kDefaultTextFont];
    
    _tipsViewDrawColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    _tipsViewTextColor = UIColor.whiteColor;
    _tipsViewPosition = kTipsViewPosition;
    _tipsViewSize = CGSizeMake(kTipsViewSize, kTipsViewSize);
}

- (void)prepareFeedBackGenertor
{
    if (@available(iOS 10.0, *)) {
        _feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [_feedBackGenertor prepare];
    }
    
}

- (void)addIndexTipsView
{
    _indexTipsView = [SSIndexTipsView new];
    _indexTipsView.frame = CGRectMake(_tipsViewPosition, 0, _tipsViewSize.width, _tipsViewSize.height);
    _indexTipsView.drawColor = _tipsViewDrawColor;
    _indexTipsView.tipsLabel.textColor = _tipsViewTextColor;
    _indexTipsView.alpha = 0;
    [self addSubview:_indexTipsView];
}

#pragma mark -

- (void)removeAllLabel
{
    while (_labelArray.count){
        UILabel *label = _labelArray.lastObject;
        [label removeFromSuperview];
        [_labelArray removeObject:label];
    }
    _preLabel = nil;
    _selectedIndex = -1;
}

- (void)recalculateFrame
{
    CGRect rect = self.frame;
    rect.size.height = _indexSource.count * _rowHeight;
    rect.origin.y = (self.superview.bounds.size.height - rect.size.height) * 0.5;//居中
    self.frame = rect;
}

- (void)addIndexLabels
{
    CGFloat width  = _rowHeight;
    CGFloat height = _rowHeight;
    CGFloat x = (self.bounds.size.width - width) * 0.5;
    CGFloat y = 0;
    
    for (NSInteger i=0; i<_indexSource.count; i++) {
        y = _rowHeight * i;
        
        UILabel *indexLabel = [UILabel new];
        indexLabel.frame = CGRectMake(x, y, width, height);
        indexLabel.textAlignment = NSTextAlignmentCenter;
        indexLabel.text = _indexSource[i];
        indexLabel.font = _textNormalFont;
        indexLabel.textColor = _textNormalColor;
        indexLabel.layer.cornerRadius = width * 0.5;
        indexLabel.clipsToBounds = YES;
        
        [self addSubview:indexLabel];
        [_labelArray addObject:indexLabel];
    }
}

#pragma mark - select index

- (BOOL)selectIndexInTouchPoint:(CGPoint)touchPoint
{
    BOOL isFind = NO;
    NSInteger index = 0;
    for (NSInteger i=0; i<_labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        if (CGRectContainsPoint(label.frame, touchPoint)) {
            index = i;
            isFind = YES;
            break;
        }
    }
    
    if (!isFind) return NO;
    if (_selectedIndex == index) return NO;
    
    _selectedIndex = index;
    [self selectIndexDidChanged:YES];
    
    return YES;
}

- (void)selectIndexDidChanged:(BOOL)isTouch
{
    _preLabel.textColor = _textNormalColor;
    _preLabel.backgroundColor = _backgroundNormalColor;
    _preLabel.font = _textNormalFont;
    
    _preLabel = _labelArray[_selectedIndex];
    _preLabel.textColor = _textSelectColor;
    _preLabel.backgroundColor = _backgroundSelectColor;
    _preLabel.font = _textSelectFont;
    
    if (!isTouch) return;
    
    NSString *title = _indexSource[_selectedIndex];
    
    CGPoint center = _indexTipsView.center;
    center.y = _preLabel.center.y;
    _indexTipsView.center = center;
    _indexTipsView.tipsLabel.text = title;
    
    if (_canFeedback) {
        if (@available(iOS 10.0, *)) {
            [_feedBackGenertor impactOccurred];
        }
    }
    
    //回调
    if (_delegate &&
        [_delegate conformsToProtocol:@protocol(SSIndexBarDelegate)] &&
        [_delegate respondsToSelector:@selector(SSIndexBar:indexDidChanged:title:)]) {
        [_delegate SSIndexBar:self indexDidChanged:_selectedIndex title:title];
    }
    
    if (_indexDidChangedBlock) {
        _indexDidChangedBlock(_selectedIndex, title);
    }
}

#pragma mark - reload Methods

- (void)reloadData
{
    [self removeAllLabel];
    [self recalculateFrame];
    [self addIndexLabels];
}

- (void)reloadLabelText
{
    for (NSInteger i=0; i<_labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        label.text = _indexSource[i];
    }
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canClick) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    if (![self selectIndexInTouchPoint:touchPoint]) return;
    
    if (_animation) {
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.indexTipsView.alpha = 1;
        }];
    } else {
        self.indexTipsView.alpha = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canClick) return;
    
    if (_animation) {
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.indexTipsView.alpha = 0;
        }];
    } else {
        self.indexTipsView.alpha = 0;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canSwipe) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    if (![self selectIndexInTouchPoint:touchPoint]) return;
    
    if (_animation) {
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.indexTipsView.alpha = 1;
        }];
    } else {
        self.indexTipsView.alpha = 1;
    }
}

#pragma mark - setter

- (void)setIndexSource:(NSArray *)indexSource
{
    BOOL isCountSame = (_indexSource.count == indexSource.count);
    
    _indexSource = indexSource;
    
    if (isCountSame) {
        [self reloadLabelText];
    } else {
        [self reloadData];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self selectIndexDidChanged:NO];
}

- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    [self reloadData];
}

- (void)setTipsViewHidden:(BOOL)tipsViewHidden
{
    _tipsViewHidden = tipsViewHidden;
    _indexTipsView.hidden = tipsViewHidden;
}

- (void)setTextNormalFont:(UIFont *)textNormalFont
{
    _textNormalFont = textNormalFont;
    for (NSInteger i=0; i<_labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        label.font = _textNormalFont;
    }
    _preLabel.font = _textSelectFont;
}

- (void)setTextSelectFont:(UIFont *)textSelectFont
{
    _textSelectFont = textSelectFont;
    _preLabel.font = _textSelectFont;
}

- (void)setTextNormalColor:(UIColor *)textNormalColor
{
    _textNormalColor = textNormalColor;
    for (NSInteger i=0; i<_labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        label.textColor = _textNormalColor;
    }
    _preLabel.textColor = _textSelectColor;
}

- (void)setTextSelectColor:(UIColor *)textSelectColor
{
    _textSelectColor = textSelectColor;
    _preLabel.textColor = _textSelectColor;
}

- (void)setBackgroundNormalColor:(UIColor *)backgroundNormalColor
{
    _backgroundNormalColor = backgroundNormalColor;
    for (NSInteger i=0; i<_labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        label.backgroundColor = _backgroundNormalColor;
    }
    _preLabel.backgroundColor = _backgroundSelectColor;
}

- (void)setBackgroundSelectColor:(UIColor *)backgroundSelectColor
{
    _backgroundSelectColor = backgroundSelectColor;
    _preLabel.backgroundColor = _backgroundSelectColor;
}

- (void)setTipsViewDrawColor:(UIColor *)tipsViewDrawColor
{
    _tipsViewDrawColor = tipsViewDrawColor;
    _indexTipsView.drawColor = _tipsViewDrawColor;
}

- (void)setTipsViewTextColor:(UIColor *)tipsViewTextColor
{
    _tipsViewTextColor = tipsViewTextColor;
    _indexTipsView.tipsLabel.textColor = _tipsViewTextColor;
}

@end
