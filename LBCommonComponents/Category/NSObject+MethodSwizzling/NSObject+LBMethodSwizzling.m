//
//  NSObject+LBMethodSwizzling.m
//  LBCommonComponentsExample
//
//  Created by 刘彬 on 2020/7/9.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "NSObject+LBMethodSwizzling.h"

@implementation NSObject (LBMethodSwizzling)
+(void)lb_swizzleInstance:(BOOL)isInstance class:(Class )originalClass withClass:(Class )swizzledClass method:(SEL )originalSelector withMethod:(SEL )swizzledSelector{
    
    originalClass = isInstance?originalClass:object_getClass(originalClass);//关键
    
    Method originalMethod;
    Method swizzledMethod;
    
    BOOL respondsMethod = NO;
    if (isInstance) {
        originalMethod = class_getInstanceMethod(originalClass, originalSelector);
        swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
        respondsMethod = [originalClass instancesRespondToSelector:swizzledSelector];
    }else{
        originalMethod = class_getClassMethod(originalClass, originalSelector);
        swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector);
        respondsMethod = [originalClass respondsToSelector:swizzledSelector];
    }
    
    BOOL registerMethod = class_addMethod(originalClass,
    swizzledSelector,
    method_getImplementation(swizzledMethod),
    method_getTypeEncoding(swizzledMethod));
    
    if (respondsMethod == NO) {
        respondsMethod = registerMethod;
    }
    if (!respondsMethod) {
        return;
    }
    
    if (isInstance) {
        swizzledMethod = class_getInstanceMethod(originalClass, swizzledSelector);
    }else{
        swizzledMethod = class_getClassMethod(originalClass, swizzledSelector);
    }
    
    if (!swizzledMethod) {
        return;
    }
    
    BOOL didAddMethod = class_addMethod(originalClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(originalClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
