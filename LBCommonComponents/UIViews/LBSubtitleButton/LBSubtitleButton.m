//
//  LBSubtitleButton.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/25.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBSubtitleButton.h"

@implementation LBSubtitleButton
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.numberOfLines = 0;
        _lineSpacing = 0;
        _text = @"";
        _detailText = @"";
        _textColor = [UIColor blackColor];
        _detailTextColor = [UIColor blackColor];
        _textFont = [UIFont systemFontOfSize:14];
        _detailTextFont = [UIFont systemFontOfSize:14];
    }
    return self;
}
-(void)setText:(NSString *)text{
    _text = text;
    [self reloadTitle];
}
-(void)setDetailText:(NSString *)detailText{
    _detailText = detailText;
    [self reloadTitle];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self reloadTitle];
}
-(void)setDetailTextColor:(UIColor *)detailTextColor{
    _detailTextColor = detailTextColor;
    [self reloadTitle];
}
-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    [self reloadTitle];
}
-(void)setDetailTextFont:(UIFont *)detailTextFont{
    _detailTextFont = detailTextFont;
    [self reloadTitle];
}
-(void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    [self reloadTitle];
}
-(void)reloadTitle{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = _lineSpacing;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",_text,_detailText]];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:_textColor,NSFontAttributeName:_textFont} range:NSMakeRange(0, _text.length)];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:_detailTextColor,NSFontAttributeName:_detailTextFont} range:NSMakeRange(_text.length+1, _detailText.length)];
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
}
@end
