//
//  FunctionalTextField.h
//  FunctionalTextField
//
//  Created by 刘彬 on 16/3/28.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FTextFieldInputType) {
    FBankCardNumberInput = 1,
    FMoneyInput,
    FIDCardNumberInput,
    FPhoneNumberInput,
    FIndateInput,
    FCVV2Input,
    FCodeInput,
    FPasswordInput,
    FPayPasswordInput,
    FPercentInput
};
@interface LBFunctionalTextField : UITextField
@property(nonatomic,getter=the_inputType)FTextFieldInputType f_inputType;
@property(nonatomic,readonly,strong)NSError *f_inputError;
@property(nonatomic,strong)NSPredicate *f_inputPredicate;
@property(nonatomic,assign)BOOL f_numberFormated;//手机号和银行卡自动插入空格分隔
@property(nonatomic,assign)NSUInteger f_codeLength;//在设置f_inputType=FCodeInput时有效

+(BOOL)textField:(LBFunctionalTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end


