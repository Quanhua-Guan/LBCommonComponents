//
//  LBVerticalButton.h
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/23.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBVerticalButton : UIButton
@property (nonatomic,assign)CGFloat lineSpacing;//default 5.f
@property (nonatomic,strong,readonly)UIButton *badgeButton;
@end

NS_ASSUME_NONNULL_END
