//
//  LBUIMacro.h
//  CommonComponentsTestProject
//
//  Created by 刘彬 on 2019/2/22.
//  Copyright © 2019 BIN. All rights reserved.
//

#ifndef LBUIMacro_h
#define LBUIMacro_h

#define UIColorRGBA(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define UIColorRGB(R, G, B)  UIColorRGBA(R,G,B,1.0)
#define UIColorRGBHex(rgbValue) UIColorRGB(((rgbValue & 0xFF0000) >> 16), ((rgbValue & 0x00FF00) >> 8), (rgbValue & 0x0000FF))
#define UIColorRGBAHex(rgbValue,A) UIColorRGBA(((rgbValue & 0xFF0000) >> 16), ((rgbValue & 0x00FF00) >> 8), (rgbValue & 0x0000FF), A)

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define KEY_WINDOW \
({\
UIWindow *keyWidow;\
if (@available(ios 13, *)) {\
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){\
        if (windowScene.activationState == UISceneActivationStateForegroundActive){\
            keyWidow = windowScene.windows.firstObject;\
            break;\
        }\
    }\
}else{\
    keyWidow = [UIApplication sharedApplication].keyWindow;\
}\
keyWidow;\
})

#define SafeAreaInsetsTop(vc) \
({\
        CGFloat safeAreaInsetsTop = 0;\
        if (@available(ios 13, *)) {\
            safeAreaInsetsTop = CGRectGetMaxY(KEY_WINDOW.windowScene.statusBarManager.statusBarFrame);\
        }else{\
            safeAreaInsetsTop = CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame);\
        }\
        if(vc.navigationController && !vc.navigationController.navigationBar.hidden && !vc.navigationController.navigationBarHidden){\
            safeAreaInsetsTop += CGRectGetHeight(vc.navigationController.navigationBar.frame);\
        }\
        safeAreaInsetsTop;\
})


#define SafeAreaInsetsBottom(vc) \
({\
CGFloat safeAreaInsetsBottom = 0;\
if (@available(iOS 11.0, *)) {\
    safeAreaInsetsBottom = KEY_WINDOW.safeAreaInsets.bottom;\
}\
if(vc.tabBarController && !vc.tabBarController.tabBar.hidden && !vc.hidesBottomBarWhenPushed){\
    safeAreaInsetsBottom  += CGRectGetHeight(vc.tabBarController.tabBar.frame);\
}\
safeAreaInsetsBottom;\
})

#define SafeAreaInsetsTopAndBottom(vc) \
({\
SafeAreaInsetsTop(vc) + SafeAreaInsetsBottom(vc);\
})

#endif /* LBUIMacro_h */
