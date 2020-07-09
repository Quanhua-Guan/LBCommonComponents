//
//  NSObject+LBMethodSwizzling.h
//  LBCommonComponentsExample
//
//  Created by 刘彬 on 2020/7/9.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LBMethodSwizzling)
+(void)lb_swizzleInstance:(BOOL)isInstance class:(Class )originalClass withClass:(Class )swizzledClass method:(SEL )originalSelector withMethod:(SEL )swizzledSelector;
@end

NS_ASSUME_NONNULL_END
