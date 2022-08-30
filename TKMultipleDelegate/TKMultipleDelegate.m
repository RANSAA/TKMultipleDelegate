//
//  TKMultipleDelegate.m
//  TKMultiDelegateDemo
//
//  Created by PC on 2022/1/18.
//

#import "TKMultipleDelegate.h"


#ifndef TKLog
#ifdef DEBUG
#define TKLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define TKLog(...);
#endif
#endif



@interface TKMultipleDelegate ()
//弱引用数组：用于存放所有的delegate对象
@property (nonatomic, readonly) NSPointerArray *delegates;
@end


@implementation TKMultipleDelegate

- (instancetype)init
{
    if (self = [super init]) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
        _isAbort = YES;
    }
    return self;
}

- (NSUInteger)count
{
    return _delegates.allObjects.count;
}

- (NSArray *)allObjects
{
    return _delegates.allObjects;;
}


//检查弱引用数组中是否已经存在delegate对象，防止重复添加
- (NSUInteger)indexOfDelegate:(id)delegate {
    @synchronized (self) {
        for (NSUInteger i = 0; i < _delegates.count; i++) {
            if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
                return i;
            }
        }
        return NSNotFound;
    }
}


- (void)addDelegate:(id)delegate
{
    @synchronized (self) {
        if ([self indexOfDelegate:delegate] == NSNotFound) {
            [_delegates addPointer:(__bridge void*)delegate];
            [_delegates addPointer:NULL];
            [_delegates compact];
        }
    }
}


- (void)removeDelegate:(id)delegate
{
    @synchronized (self) {
        NSUInteger index = [self indexOfDelegate:delegate];
        if (index != NSNotFound) {
          [_delegates removePointerAtIndex:index];
        }
        [_delegates addPointer:NULL];
        [_delegates compact];
    }
}


- (void)removeDelegateAtIndex:(NSUInteger)index
{
    @synchronized (self) {
        [_delegates removePointerAtIndex:index];
        [_delegates addPointer:NULL];
        [_delegates compact];
    }
}

- (void)removeAllDelegates
{
    @synchronized (self) {
        _delegates.count = 0;
        [_delegates addPointer:NULL];
        [_delegates compact];
    }
}


#pragma mark objc-msg
- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
      return YES;
    }
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }

    [_delegates compact];
    for (id delegate in _delegates) {
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }

    //实现一个空的NSMethodSignature
    if (!signature) {
        NSString *reason;
        reason = [NSString stringWithFormat:@"⚠️unrecognized selector ==> [%@ %@]",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"⚠️%@实例本身未实现:%@  或者",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"⚠️%@实例内部未添加子delegate  或者",self.class];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"⚠️%@实例内部所添加的delegate对象都未实现:%@",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);

#if DEBUG
        if (self.isAbort) {
            abort();
        }
#endif
        signature = [NSMethodSignature signatureWithObjCTypes:@encode(void)];
    }
    return signature;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSUInteger argumentCount = anInvocation.methodSignature.numberOfArguments;
    if (argumentCount < 2) {
        return;
    }else{
        SEL selector = [anInvocation selector];
        // 将消息发送对象转发到self.delegates中的所有对象中
        for (id delegate in _delegates) {
            if (delegate && [delegate respondsToSelector:selector]) {
                [anInvocation invokeWithTarget:delegate];
            }
        }
    }
}

@end
