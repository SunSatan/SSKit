//
//  SSReusablePool.h
//
//  Created by SunSatan on 2020/8/23.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSReusablePool : NSObject // 视图的可重用池
/**
 * 根据标识符将可重用池中可重用的 view 出队列
 * @param identifier 标识符
 */
- (id)dequeueReusableViewWithIdentifier:(NSString *)identifier;
/**
 * 向重用池注册 viewClass 和 viewClass 的标识符
 * @param viewClass  标识符
 * @param identifier 标识符
 */
- (void)registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier;
/**
 * 重置所有 view 到可重用池中
 */
- (void)resetReusablePool;

@end

NS_ASSUME_NONNULL_END
