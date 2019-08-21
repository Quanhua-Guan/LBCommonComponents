//
//  LBTextField.h
//  LBTextField
//
//  Created by 刘彬 on 16/3/28.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LBInputType) {
    LBBankCardInput = 1,
    LBMoneyInput,
    LBIDCardInput,
    LBMobileInput,
    LBIndateInput,
    LBCVV2Input,
    LBCodeInput,
    LBPasswordInput,
    LBPayPasswordInput,
    LBPercentInput
};
@interface LBTextField : UITextField
@property(nonatomic,assign)LBInputType lb_inputType;
@property(nonatomic,strong)NSPredicate *lb_inputPredicate;
@property(nonatomic,assign)BOOL lb_numberFormated;//手机号和银行卡自动插入空格分隔
@property(nonatomic,assign)NSUInteger lb_maxLength;//对应每个lb_inputType有其默认值
@property(nonatomic,strong)NSArray<NSString *> *unablePerformActions;//不响应的方法列表 (例如：NSStringFromSelector(@selector(paste:))--->禁止粘贴)
@property(nonatomic,readonly,strong)NSError *lb_inputError;

+(BOOL)textField:(LBTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end


