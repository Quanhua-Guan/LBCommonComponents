//
//  UIViewController+LBNavigationBarAppearance.h
//
//  Created by 刘彬 on 2020/10/14.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LBNavigationBarAppearanceStyle) {
    LBNavigationBarDefault = 0,//系统
    LBNavigationBarTransparent,//透明，
    LBNavigationBarTransparentShadowLine,//透明，有分割线
    LBNavigationBarHidden//隐藏
};
@interface UIViewController (LBNavigationBarAppearance)
-(void)setNavigationBarAppearanceStyle:(LBNavigationBarAppearanceStyle)style tintColor:(nullable UIColor *)color;
@end

@interface UINavigationBar (LBAppearance)
@property (nonatomic, assign) BOOL lb_appearanceAvailable;
@property (nonatomic, copy  ) NSString *lb_backItemTitle;
@end

NS_ASSUME_NONNULL_END
