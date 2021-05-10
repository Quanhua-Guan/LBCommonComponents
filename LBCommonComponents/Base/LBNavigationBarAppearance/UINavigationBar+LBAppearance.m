//
//  UINavigationBar+LBAppearance.m
//  Site
//
//  Created by 刘彬 on 2021/5/10.
//  Copyright © 2021 yc. All rights reserved.
//

#import "UINavigationBar+LBAppearance.h"
#import <objc/runtime.h>

static NSString *LBNavigationBarAppearanceAvailableKey = @"LBNavigationBarAppearanceAvailableKey";
static NSString *LBBackItemTitleKey = @"LBBackItemTitleKey";

@implementation UINavigationBar (LBAppearance)
- (void)setLb_appearanceAvailable:(BOOL)lb_appearanceAvailable{
    objc_setAssociatedObject(self, &LBNavigationBarAppearanceAvailableKey, @(lb_appearanceAvailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)lb_appearanceAvailable{
    return [objc_getAssociatedObject(self, &LBNavigationBarAppearanceAvailableKey) doubleValue];
}

-(void)setLb_backItemTitle:(NSString *)lb_backItemTitle{
    objc_setAssociatedObject(self, &LBBackItemTitleKey, lb_backItemTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)lb_backItemTitle{
    return objc_getAssociatedObject(self, &LBBackItemTitleKey);
}
@end
