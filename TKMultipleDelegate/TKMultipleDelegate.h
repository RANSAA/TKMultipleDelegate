//
//  TKMultipleDelegate.h
//  TKMultiDelegateDemo
//
//  Created by PC on 2022/1/18.
//

#import <Foundation/Foundation.h>

/**
 iOS多代理实现类
 */

NS_ASSUME_NONNULL_BEGIN

@interface TKMultipleDelegate : NSObject
@property (nonatomic, copy,   readonly) NSArray *allObjects;//所有的代理对象
@property (nonatomic, assign, readonly) NSUInteger count;//已经添加的代理数量
@property (nonatomic, assign) BOOL isAbort;//Debug模式下出现unrecognized selector时，是否终止程序。 默认YES

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (void)removeDelegateAtIndex:(NSUInteger)index;
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
