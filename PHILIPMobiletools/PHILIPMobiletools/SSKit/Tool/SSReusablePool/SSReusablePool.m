//
//  SSReusablePool.m
//
//  Created by SunSatan on 2020/8/23.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSReusablePool.h"
#import "SSMacro.h"
#import <UIKit/UIKit.h>

static NSString * const ssViewObserverKeyPath = @"frame";

@interface SSReusablePool ()

@property (strong, nonatomic) NSMutableSet *usingQueue;//可重用队列
@property (strong, nonatomic) NSMutableSet *reusableQueue;//正在使用队列
@property (strong, nonatomic) NSMutableDictionary *identifierPool;//标识符池

@end

@implementation SSReusablePool

- (void)dealloc
{
    NSLog(@"SSReusablePool -----> dealloc");
    //移除所有观察者
    [self removeObserverInSet:_usingQueue    forKeyPath:ssViewObserverKeyPath];
    [self removeObserverInSet:_reusableQueue forKeyPath:ssViewObserverKeyPath];
}

- (instancetype)init
{
    if (self = [super init]) {
        _usingQueue     = [NSMutableSet set];
        _reusableQueue  = [NSMutableSet set];
        _identifierPool = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier
{
    assert(viewClass);
    assert(identifier);
    
    _identifierPool[identifier] = viewClass;
}

- (id)dequeueReusableViewWithIdentifier:(NSString *)identifier
{
    assert(identifier);
    assert([_identifierPool.allKeys containsObject:identifier]);
    
    NSDictionary *idViewDict = [self findElementInSet:_reusableQueue forIdentifier:identifier];
    
    if (fastpath(idViewDict)) {
        //重用视图
        [_reusableQueue removeObject:idViewDict];
        [_usingQueue addObject:idViewDict];
        UIView *view = idViewDict[identifier];
        return view;
    }
    
    //根据class动态创建实例对象
    Class cls = _identifierPool[identifier];
    id view = [cls new];
    [_usingQueue addObject:@{identifier:view}];
    //添加kvo监听，实现可重用池的自动回收
    [view addObserver:self forKeyPath:ssViewObserverKeyPath options:NSKeyValueObservingOptionNew context:nil];

    return view;
}

- (void)reusablePoolRecycleView:(UIView *)view
{
    NSDictionary *idViewDict = [self findElementInSet:_usingQueue forView:view];
    [_reusableQueue addObject:idViewDict];
    [_usingQueue removeObject:idViewDict];
}

- (void)resetReusablePool
{
    NSDictionary *idViewDict = nil;
    while ((idViewDict = _usingQueue.anyObject)) {
        [_reusableQueue addObject:idViewDict];
        [_usingQueue removeObject:idViewDict];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //判断view出了父视图的frame，还可以优化
    UIView *view = (UIView *)object;
    if (!view.superview) return;
    if (CGRectIntersectsRect(view.frame, view.superview.frame)) return;
    
    [self reusablePoolRecycleView:view];
}

#pragma mark - NSSet operation

- (NSDictionary *)findElementInSet:(NSSet *)set forView:(UIView *)view
{
    NSDictionary *idViewDict = nil;
    for (NSDictionary *element in set) {
        UIView *elementView = element.allValues.lastObject;
        if ([view isEqual:elementView]) {
            idViewDict = element;
            break;
        }
    }
    return idViewDict;
}

- (NSDictionary *)findElementInSet:(NSSet *)set forIdentifier:(NSString *)identifier
{
    NSDictionary *idViewDict = nil;
    for (NSDictionary *element in set) {
        NSString *viewIdString = element.allKeys.lastObject;
        if ([identifier isEqualToString:viewIdString]) {
            idViewDict = element;
            break;
        }
    }
    return idViewDict;
}

- (void)removeObserverInSet:(NSSet *)set forKeyPath:(NSString *)keyPath
{
    for (NSDictionary *element in set) {
        id elementView = element.allValues.lastObject;
        [elementView removeObserver:self forKeyPath:keyPath];
    }
}

@end
