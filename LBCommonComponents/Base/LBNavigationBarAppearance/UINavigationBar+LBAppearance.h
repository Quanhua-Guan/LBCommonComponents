//
//  UINavigationBar+LBAppearance.h
//  Site
//
//  Created by 刘彬 on 2021/5/10.
//  Copyright © 2021 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (LBAppearance)
@property (nonatomic, assign) BOOL lb_appearanceAvailable;
@property (nonatomic, copy  ) NSString *lb_backItemTitle;
@end

NS_ASSUME_NONNULL_END
