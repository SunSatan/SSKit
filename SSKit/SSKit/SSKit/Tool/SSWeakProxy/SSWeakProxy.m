//
//  SSWeakProxy.m
//  SSKit
//
//  Created by SunSatan on 2020/10/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSWeakProxy.h"

@implementation SSWeakProxy

- (void)dealloc
{
    NSLog(@"SSWeakProxy -> dealloc");
}

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target
{
    return [SSWeakProxy.alloc initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object
{
    return [_target isEqual:object];
}

- (NSUInteger)hash
{
    return [_target hash];
}

- (Class)superclass
{
    return [_target superclass];
}

- (Class)class
{
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy
{
    return YES;
}

- (NSString *)description
{
    return [_target description];
}

- (NSString *)debugDescription
{
    return [_target debugDescription];
}

@end
