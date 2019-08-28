//
//  FLBTextField.m
//  LBTextField
//
//  Created by 刘彬 on 16/3/28.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBTextField.h"

@interface LBTextField ()
@property (nonatomic,assign)BOOL setMaxLength;
@property (nonatomic,strong)NSString *beforePastingText;
@end

@implementation LBTextField

- (instancetype)init
{
    self = [[self.class alloc] initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    return self;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    [super setKeyboardType:keyboardType];
    if (keyboardType == UIKeyboardTypeNumberPad) {
        self.lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]*"];
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(paste:)) {//粘贴
        _beforePastingText = self.text;
    }
    if ([self.unablePerformActions containsObject:NSStringFromSelector(action)]) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)setLb_maxLength:(NSUInteger)lb_maxLength{
    _lb_maxLength = lb_maxLength;
    _setMaxLength = YES;
}

-(void)setLb_inputType:(LBInputType)lb_inputType{
    _lb_inputType = lb_inputType;
    switch (lb_inputType) {
        case LBMobileInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 11;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBBankCardInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 19;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBCVV2Input:
            if (!_setMaxLength) {
                self.lb_maxLength = 3;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBCodeInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 6;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBPayPasswordInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 6;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBIndateInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 4;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBPercentInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 3;
            }
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case LBMoneyInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 15;
            }
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case LBPasswordInput:
            if (!_setMaxLength) {
                self.lb_maxLength = 16;
            }
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        default:
            break;
    }
}
-(NSError *)lb_inputError{
    NSString *errorDescription = nil;
    if (!self.text.length){
        errorDescription = [self.placeholder rangeOfString:@"输入"].length?self.placeholder:[NSString stringWithFormat:@"请输入%@",self.placeholder];
    }else{
        switch (self.lb_inputType) {
            case LBBankCardInput:
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(\\d{14,20})"];
                }
                if (![_lb_inputPredicate evaluateWithObject:self.text]){
                    errorDescription = @"请输入正确的银行卡号";
                }
                break;
            case LBMoneyInput:
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]+(.[0-9]{1,2})?$"];
                }
                if (![self.text floatValue] || ![_lb_inputPredicate evaluateWithObject:self.text]) {
                    errorDescription = @"请输入有效金额";
                }
                break;
            case LBIDCardInput:
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
                }
                if (![_lb_inputPredicate evaluateWithObject:self.text]){
                    errorDescription = @"请输入正确的身份证号码";
                }
                break;
            case LBMobileInput:
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1(\\d{10})"];
                }
                if (![_lb_inputPredicate evaluateWithObject:self.text]){
                    errorDescription = @"请输入正确的手机号码";
                }
                break;
            case LBCodeInput:
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [NSString stringWithFormat:@"\\d{%lu}",_lb_maxLength]];
                }
                if (![_lb_inputPredicate evaluateWithObject:self.text]){
                    errorDescription = [NSString stringWithFormat:@"请输入%lu位验证码",_lb_maxLength];
                }
                break;
            case LBIndateInput:
            {
                bool inputError = YES;
                if (_lb_inputPredicate) {
                    inputError = ![_lb_inputPredicate evaluateWithObject:self.text];
                }else{
                    inputError = (self.text.length < 4 || [[self.text substringToIndex:2] integerValue] > 12 || [[self.text substringToIndex:2] integerValue] == 0 || [[self.text substringFromIndex:2] integerValue] > 31 || [[self.text substringFromIndex:2] integerValue] == 0);
                }
                if (inputError){
                    errorDescription = @"请输入正确的有效期";
                }
            }
                break;
            case LBCVV2Input:
            {
                bool inputError = YES;
                if (_lb_inputPredicate) {
                    inputError = ![_lb_inputPredicate evaluateWithObject:self.text];
                }else{
                    inputError = (self.text.length < 3);
                }
                if (inputError){
                    errorDescription = @"请输入3位安全码";
                }
            }
                break;
            case LBPasswordInput:
            {
                if (!_lb_inputPredicate) {
                    _lb_inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![a-zA-Z0-9]+$)(?![^a-zA-Z/D]+$)(?![^0-9/D]+$).{8,16}$"];
                }
                if (![_lb_inputPredicate evaluateWithObject:self.text]) {
                    errorDescription = @"密码必须由8-16位字母、数字和特殊字符组成";
                }
            }
                break;
            case LBPayPasswordInput:
            {
                
                bool inputError = YES;
                if (_lb_inputPredicate) {
                    inputError = ![_lb_inputPredicate evaluateWithObject:self.text];
                }else{
                    NSUInteger index = 0;
                    BOOL isNotAllEnqual = NO;
                    while ((!isNotAllEnqual) && (index+1) < self.text.length) {
                        if ([[self.text substringWithRange:NSMakeRange(index, 1)] isEqualToString:[self.text substringWithRange:NSMakeRange(index+1, 1)]]) {
                            index ++;
                        }else{
                            isNotAllEnqual = YES;
                        }
                    }
                    
                    NSUInteger index2 = 0;
                    BOOL isNotAscending = NO;
                    while ((!isNotAscending) && (index2+1) < self.text.length) {
                        if ([[self.text substringWithRange:NSMakeRange(index2, 1)] integerValue] + 1 == [[self.text substringWithRange:NSMakeRange(index2+1, 1)] integerValue]) {
                            index2 ++;
                        }else{
                            isNotAscending = YES;
                        }
                    }
                    
                    NSUInteger index3 = 0;
                    BOOL isNotDescending = NO;
                    while ((!isNotDescending) && (index3+1) < self.text.length) {
                        if ([[self.text substringWithRange:NSMakeRange(index3, 1)] integerValue] - 1 == [[self.text substringWithRange:NSMakeRange(index3+1, 1)] integerValue]) {
                            index3 ++;
                        }else{
                            isNotDescending = YES;
                        }
                    }
                    
                    inputError = (!isNotAllEnqual || !isNotAscending || !isNotDescending || [self.text isEqualToString:@"123456"] ||  [self.text isEqualToString:@"654321"]);
                    
                }
                
                if (inputError) {
                    errorDescription = @"为了您的账户安全，请避免输入过于简单的支付密码";
                }
            }
                break;
            default:
                if (_lb_inputPredicate && ![_lb_inputPredicate evaluateWithObject:self.text]){
                    errorDescription = @"输入格式错误";
                }
                break;
        }
    
    }
    NSError *inputError = nil;
    if (errorDescription) {
        inputError = [NSError errorWithDomain:@"FInputError" code:9999 userInfo:@{NSLocalizedDescriptionKey:errorDescription}];
    }
    return inputError;
}

-(NSString *)text{
    if (_lb_numberFormated) {
        return [[super text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return [super text];
}


-(void)textFieldTextDidChange:(NSNotification *)notification{
    if (_lb_inputPredicate && ![_lb_inputPredicate evaluateWithObject:self.text]){
        self.text = _beforePastingText;
    }else if (_setMaxLength && (self.text.length>_lb_maxLength)){
        self.text = [self.text substringToIndex:_lb_maxLength];
    }
    
    if (self.lb_inputType == LBBankCardInput) {
        if (_lb_numberFormated) {
            NSMutableString *string = [self.text mutableCopy];
            while ([[string componentsSeparatedByString:@" "] lastObject].length > 4) {
                NSUInteger spaceNumber = [string componentsSeparatedByString:@" "].count-1;
                [string insertString:@" " atIndex:spaceNumber+(spaceNumber+1)*4];
            }
            self.text = string;
        }
    }else if (self.lb_inputType == LBMobileInput){
        if (_lb_numberFormated) {
            NSMutableString *string = [self.text mutableCopy];
            while ([[string componentsSeparatedByString:@" "] lastObject].length > ((string.length<7)?3:4)) {
                NSUInteger spaceNumber = [string componentsSeparatedByString:@" "].count-1;
                if (string.length<7) {
                    [string insertString:@" " atIndex:3];
                }else{
                    [string insertString:@" " atIndex:3+spaceNumber+spaceNumber*4];
                }
                
            }
            self.text = string;
        }
    }else if (self.lb_inputType == LBMoneyInput){
        if ([self.text rangeOfString:@"."].length && [[self.text componentsSeparatedByString:@"."] lastObject].length >2) {
            self.text = [self.text substringToIndex:4];
        }
    }else if (self.lb_inputType == LBPercentInput){
        if (self.text.integerValue > 100) {
            self.text = @"100";
        }
    }
}

+(BOOL)textField:(LBTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isKindOfClass:[LBTextField class]] && string.length) {
        if (textField.lb_inputPredicate && ![textField.lb_inputPredicate evaluateWithObject:[textField.text stringByAppendingString:string]]){
            return NO;
        }
        else if (textField.lb_inputType == LBMoneyInput){
            if ([textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
                return NO;
            }else if (!textField.text.length && [string isEqualToString:@"."]){
                textField.text = @"0";
                return YES;
            }else if ([textField.text rangeOfString:@"."].length){
                if ([[textField.text componentsSeparatedByString:@"."] lastObject].length >=2) {
                    return NO;
                }else if ([string isEqualToString:@"."]){
                    return NO;
                }
            }
        }else if (textField.lb_inputType == LBPercentInput){
            if (textField.text.integerValue >= 100) {
                return NO;
            }
        }else{
            if (textField.setMaxLength && (textField.text.length>(textField.lb_maxLength-1))) {
                return NO;
            }
        }
    }
    return YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end


@implementation UIResponder (TextFieldDelegateResolveInvocation)
-(BOOL)respondsToSelector:(SEL)aSelector{
    if (aSelector == @selector(textField:shouldChangeCharactersInRange:replacementString:)) {
        
        return [super respondsToSelector:aSelector]
        ||[LBTextField respondsToSelector:aSelector];
        
    }
    return [super respondsToSelector:aSelector];
}
//当delegate未实现代理方法的时候让LBTextField类方法实现
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(textField:shouldChangeCharactersInRange:replacementString:)) {
        
        if (![super respondsToSelector:aSelector] && [LBTextField respondsToSelector:aSelector]) {
            
            return LBTextField.self;
            
        }
    }
    return [super forwardingTargetForSelector: aSelector];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

