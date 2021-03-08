//
//  UIViewController+LBNavigationBarAppearance.m
//
//  Created by 刘彬 on 2020/10/14.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "UIViewController+LBNavigationBarAppearance.h"
#import "NSObject+LBMethodSwizzling.h"

static NSString *LBNavigationBarAppearanceStyleKey = @"LBNavigationBarAppearanceStyleKey";
static NSString *LBNavigationBarTintColorKey = @"LBNavigationBarTintColorKey";

@interface UIViewController (LBNavigationBarAppearance)
@property (nonatomic, assign) LBNavigationBarAppearanceStyle navigationBarAppearanceStyle;
@property (nonatomic, strong) UIColor *navigationBarTintColor;
@end

@implementation UIViewController (LBNavigationBarAppearance)

+(void)load{
    [self lb_swizzleMethodClass:self.class
                         method:@selector(viewDidLoad)
          originalIsClassMethod:NO
                      withClass:self
                     withMethod:@selector(lb_navigationBarAppearance_viewDidLoad)
          swizzledIsClassMethod:NO];
    
    
    [self lb_swizzleMethodClass:self.class
                         method:@selector(viewWillAppear:)
          originalIsClassMethod:NO
                      withClass:self
                     withMethod:@selector(lb_navigationBarAppearance_viewWillAppear:)
          swizzledIsClassMethod:NO];
    
    
    [self lb_swizzleMethodClass:self.class
                         method:@selector(viewWillDisappear:)
          originalIsClassMethod:NO
                      withClass:self
                     withMethod:@selector(lb_navigationBarAppearance_viewWillDisappear:)
          swizzledIsClassMethod:NO];
}

-(LBNavigationBarAppearanceStyle)navigationBarAppearanceStyle{
    return [objc_getAssociatedObject(self, &LBNavigationBarAppearanceStyleKey) integerValue];
}
-(void)setNavigationBarAppearanceStyle:(LBNavigationBarAppearanceStyle)navigationBarAppearanceStyle{
    if (navigationBarAppearanceStyle != LBNavigationBarHidden && self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
    objc_setAssociatedObject(self, &LBNavigationBarAppearanceStyleKey, @(navigationBarAppearanceStyle), OBJC_ASSOCIATION_ASSIGN);
}
-(UIColor *)navigationBarTintColor{
    return objc_getAssociatedObject(self, &LBNavigationBarTintColorKey);
}
- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor{
    objc_setAssociatedObject(self, &LBNavigationBarTintColorKey, navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setNavigationBarAppearanceStyle:(LBNavigationBarAppearanceStyle)style tintColor:(UIColor *)color{
    self.navigationBarAppearanceStyle = style;
    self.navigationBarTintColor = color;
}

-(void)lb_navigationBarAppearance_viewDidLoad{
    if ([NSStringFromClass(self.class) containsString:@"UI"] == NO) {
        if (@available(iOS 13.0, *)) {
            if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
                if (self.view.backgroundColor == nil) {
                    self.view.backgroundColor = [UIColor whiteColor];
                }
            }else{
                if (self.view.backgroundColor == nil) {
                    self.view.backgroundColor = [UIColor blackColor];
                }
            }
        }else{
            if (self.view.backgroundColor == nil) {
                self.view.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    [self lb_navigationBarAppearance_viewDidLoad];
}

-(void)lb_navigationBarAppearance_viewWillAppear:(BOOL)animated{
    if ([NSStringFromClass(self.class) containsString:@"UI"] == NO){
        switch (self.navigationBarAppearanceStyle) {
            case LBNavigationBarTransparent:
            case LBNavigationBarTransparentShadowLine:
            {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                
                if (self.navigationBarAppearanceStyle != LBNavigationBarTransparentShadowLine) {
                    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
                }
                
                if (self.navigationBarTintColor) {
                    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:self.navigationBarTintColor}];
                    
                    self.navigationController.navigationBar.tintColor = self.navigationBarTintColor;
                }

                if ([self.navigationBarTintColor isEqual:[UIColor whiteColor]]) {
                    self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //状态栏改为白色
                }else{
                    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;  //状态栏改为黑色
                }
            }
                break;
                break;
            case LBNavigationBarHidden:
                self.navigationController.navigationBarHidden = YES;
                break;
            default:
                if (@available(iOS 13.0, *)) {
                    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
                        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
                    }else{
                        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
                    }
                }else{
                    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
                }
                
                break;
        }
    }
    
    [self lb_navigationBarAppearance_viewWillAppear:animated];
    
}

-(void)lb_navigationBarAppearance_viewWillDisappear:(BOOL)animated{
    if ([NSStringFromClass(self.class) containsString:@"UI"] == NO){
        if (self.navigationBarAppearanceStyle == LBNavigationBarHidden) {
            self.navigationController.navigationBarHidden = NO;
        }
        else if (self.navigationBarAppearanceStyle != LBNavigationBarDefault){
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;  //状态栏改为黑色
            
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
            [self.navigationController.navigationBar setTitleTextAttributes:nil];
            
            
            if (@available(iOS 13.0, *)) {
                if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
                    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
                }else{
                    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
                }
            }else{
                self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            }
        }
    }
    [self lb_navigationBarAppearance_viewWillDisappear:animated];
}
@end
