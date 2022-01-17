//
//  MuProtocol.h
//  TKMultiDelegateDemo
//
//  Created by PC on 2022/1/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Protocol_1 <NSObject>
- (void)call;
- (void)more;
- (void)call:(NSString *)title  index:(NSNumber *)index;
@end

@protocol Protocol_2 <NSObject>
- (void)call;
@end

@protocol Protocol_3 <NSObject>
- (void)call;
@end

NS_ASSUME_NONNULL_END
