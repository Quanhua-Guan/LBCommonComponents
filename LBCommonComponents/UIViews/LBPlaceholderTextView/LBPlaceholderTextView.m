//
//  LBPlaceholderTextView.m
//  TransitBox
//
//  Created by 刘彬 on 2019/4/29.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBPlaceholderTextView.h"

@interface LBTextViewTextField : UITextField
@property (nonatomic,assign)LBPlaceholderTextView *textView;
@end
@implementation LBTextViewTextField

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if ([hitView isEqual:self]) {
        return (UIView *)self.textView;
    }
    return hitView;
}
@end

@interface LBPlaceholderTextView()<UITextFieldDelegate>
@end
@implementation LBPlaceholderTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = -1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        self.contentInset = UIEdgeInsetsMake((CGRectGetHeight(frame)-self.contentSize.height)/2, 0, (CGRectGetWidth(frame)-self.contentSize.width)/2, 0);
        _placeholderTextField = [[LBTextViewTextField alloc] initWithFrame:frame];
        _placeholderTextField.leftViewMode = UITextFieldViewModeAlways;
        _placeholderTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, CGRectGetHeight(frame))];
        _placeholderTextField.textView = self;
        _placeholderTextField.delegate = self;
        _placeholderTextField.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self.superview addSubview:_placeholderTextField];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderTextField.font = font;
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode{
    _clearButtonMode = clearButtonMode;
    _placeholderTextField.clearButtonMode = clearButtonMode;
    
    if (clearButtonMode != UITextFieldViewModeNever) {
        self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom, 20);
    }
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderTextField.placeholder = placeholder;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (keyPath == NSStringFromSelector(@selector(frame))) {
        self.placeholderTextField.frame = self.frame;
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)textDidChange{
    if (self.text.length) {
        self.placeholderTextField.text = @" ";//让clearButton像TextField一样正常显示
        if (_maxLength>-1 && self.text.length > _maxLength) {
            self.text = [self.text substringToIndex:_maxLength];
        }
    }else{
        self.placeholderTextField.text = nil;
    }
    
    self.contentInset = UIEdgeInsetsMake((CGRectGetHeight(self.bounds)-self.contentSize.height)/2, self.contentInset.left, (CGRectGetWidth(self.bounds)-self.contentSize.width)/2, self.contentInset.right);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.text = nil;
    [self textDidChange];
    return NO;
}
@end
