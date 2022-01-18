//
//  MuProtocol.h
//  TKMultiDelegateDemo
//
//  Created by PC on 2022/1/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Protocol1 <NSObject>
- (NSString *)call;
- (CGFloat)callRe;
- (void)more;
- (void)call:(NSString *)title  index:(NSNumber *)index;
@end

@protocol Protocol2 <NSObject>
- (NSString *)call;
@end

@protocol Protocol3 <NSObject>
- (NSString *)call;
@end

NS_ASSUME_NONNULL_END
