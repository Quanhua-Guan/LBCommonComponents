//
//  LBSubtitleButton.h
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/25.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBSubtitleButton : UIButton
@property (nonatomic,assign)CGFloat lineSpacing;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)UIColor *detailTextColor;
@property (nonatomic,strong)UIFont *textFont;
@property (nonatomic,strong)UIFont *detailTextFont;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *detailText;
@end

NS_ASSUME_NONNULL_END
