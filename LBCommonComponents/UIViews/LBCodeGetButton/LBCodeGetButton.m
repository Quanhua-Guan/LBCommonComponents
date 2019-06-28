//
//  GetCodeButton.m
//  MBP_MAPP
//
//  Created by 刘彬 on 16/4/11.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBCodeGetButton.h"

@interface LBCodeGetButton()
@property (nonatomic,strong)NSString *secondsString;
@property (nonatomic,assign)NSRange secondsRange;
@property (nonatomic,copy)void (^action)(LBCodeGetButton *sender);
@property (nonatomic,assign)UIBackgroundTaskIdentifier taskIdentifier;
@end
@implementation LBCodeGetButton

- (instancetype)initWithFrame:(CGRect)frame action:(void (^)(LBCodeGetButton *sender))action
{
    self = [super initWithFrame:frame];
    if (self) {
        _action = action;
        self.waiting = NO;
        [self addTarget:self action:@selector(getCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)getCodeButtonAction{
    __weak typeof(self) weakSelf = self;
    _action?_action(weakSelf):NULL;
}

-(void)setWaiting:(BOOL)waiting{
    _waiting = waiting;
    if (waiting) {
        self.enabled = NO;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(wait:) userInfo:self repeats:YES];
        _taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    }else{
        [super setTitle:[[self currentTitle] stringByReplacingCharactersInRange:_secondsRange withString:_secondsString] forState:UIControlStateDisabled];
        self.enabled = YES;
        [[UIApplication sharedApplication] endBackgroundTask:_taskIdentifier];
    }
}


-(void)wait:(NSTimer *)timer{
    NSInteger seconds = [[[self currentTitle] substringWithRange:_secondsRange] integerValue];
    seconds --;
    [super setTitle:[[self currentTitle] stringByReplacingCharactersInRange:_secondsRange withString:[NSString stringWithFormat:@"%0*d",(int)_secondsString.length,(int)seconds]] forState:UIControlStateDisabled];
    if (seconds == 0) {
        self.waiting = NO;
        [timer invalidate];
    }
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    if (state == UIControlStateDisabled) {
        // Intermediate
        NSMutableString *numberString = [[NSMutableString alloc] init];
        NSScanner *scanner = [NSScanner scannerWithString:[self titleForState:UIControlStateDisabled]];
        NSCharacterSet *characterSet = [NSCharacterSet decimalDigitCharacterSet];
        NSString *tempStr;
        while (![scanner isAtEnd]) {
            // Throw away characters before the first number.
            [scanner scanUpToCharactersFromSet:characterSet intoString:NULL];
            // Collect numbers.
            [scanner scanCharactersFromSet:characterSet intoString:&tempStr];
            [numberString appendString:tempStr];
            tempStr = @"";
        }
        _secondsString = numberString;
        _secondsRange = [title rangeOfString:_secondsString];
    }
}
@end
