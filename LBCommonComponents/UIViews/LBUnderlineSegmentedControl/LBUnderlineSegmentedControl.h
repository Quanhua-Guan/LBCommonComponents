//
//  TitleSwitchView.h
//  operator
//
//  Created by 刘彬 on 2019/1/11.
//  Copyright © 2019 张琛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBUnderlineSegmentedControl : UIView
@property (nonatomic,strong,readonly)UIButton *sliderButton;
@property (nonatomic,strong,readonly)NSArray<UIButton *> *itemsBtnArray;
@property (nonatomic) CGFloat lineHeight;
@property (nonatomic,strong)UIColor *underlineColor;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)UIColor *selectedTextColor;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic) NSInteger selectedSegmentIndex;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items action:(void (^ _Nullable)(__weak UIButton *sliderButton))action;
-(void)setNews:(BOOL )showNews forSegmentIndex:(NSInteger)selectedSegmentIndex;
@end

NS_ASSUME_NONNULL_END
