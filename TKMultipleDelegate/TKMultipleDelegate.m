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

- (NSUInteger)indexOfDelegate:(id)delegate {
    @synchronized (self) {
        for (NSUInteger i = 0; i < _delegates.count; i += 1) {
            if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
                return i;
            }
        }
    }
  return NSNotFound;
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

    //??????????????????NSMethodSignature
    if (!signature) {
        NSString *reason;
        reason = [NSString stringWithFormat:@"??????unrecognized selector ==> [%@ %@]",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"??????%@?????????????????????:%@  ??????",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"??????%@????????????????????????delegate  ??????",self.class];
        TKLog(@"%@",reason);
        reason = [NSString stringWithFormat:@"??????%@????????????????????????delegate??????????????????:%@",self.class,NSStringFromSelector(aSelector)];
        TKLog(@"%@",reason);

        if (self.isAbort) {
#if DEBUG
        abort();
#endif
        }
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
        for (id delegate in _delegates) {
            if (delegate && [delegate respondsToSelector:selector]) {
                [anInvocation invokeWithTarget:delegate];
            }
        }
    }
}
@end
