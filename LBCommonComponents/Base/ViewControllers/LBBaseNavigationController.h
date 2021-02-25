//
//  LBBaseNavigationController.h
//  LBBaseNavigationController
//
//  Created by 刘彬 on 2020/9/4.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBBaseNavigationController : UINavigationController
#define UINavigationController LBBaseNavigationController
@property (nonatomic, strong, nullable) UIImage *backIndicatorImage;

@end

NS_ASSUME_NONNULL_END
