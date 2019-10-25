//
//  UIButton+init.m
//  QHBranch
//
//  Created by 刘彬 on 2018/12/20.
//  Copyright © 2018 BIN. All rights reserved.
//

#import "UIButton+LBAction.h"
#import <objc/runtime.h>

@implementation UIButton (LBAction)
@dynamic action;
static NSString *LBButtonActionKey = @"LBButtonActionKey";
- (instancetype)initWithFrame:(CGRect)frame action:(void (^_Nullable)(UIButton *sender))action;
{
    self = [[self.class alloc] initWithFrame:frame];
    if (self) {
        self.action = action;
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}
-(void (^)(UIButton *_Nonnull))action{
    return objc_getAssociatedObject(self, &LBButtonActionKey);
}
-(void)setAction:(void (^)(UIButton *_Nonnull))action{
    objc_setAssociatedObject(self, &LBButtonActionKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonAction{
    __weak typeof(self) weakSelf = self;
    self.action?self.action(weakSelf):NULL;
}

@end
