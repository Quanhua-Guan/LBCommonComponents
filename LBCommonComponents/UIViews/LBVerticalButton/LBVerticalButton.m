//
//  LBVerticalButton.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/23.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBVerticalButton.h"

@interface LBVerticalButton()

@end

@implementation LBVerticalButton
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _lineSpacing = 5;
        
        _badgeButton = [[UIButton alloc] init];
        _badgeButton.hidden = YES;
        _badgeButton.clipsToBounds = YES;
        _badgeButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _badgeButton.backgroundColor = [UIColor redColor];
        [self addSubview:_badgeButton];
        
        [_badgeButton.titleLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(text)) options:NSKeyValueObservingOptionNew context:nil];
        [_badgeButton.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(image)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect imageViewFrame = self.imageView.frame;
    CGRect titleLabelFrame = self.titleLabel.frame;
    CGFloat minY = (CGRectGetHeight(self.bounds)-(CGRectGetHeight(titleLabelFrame)+CGRectGetHeight(imageViewFrame)+self.lineSpacing))/2;
    imageViewFrame.origin.y = minY;
    imageViewFrame.origin.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(imageViewFrame))/2;
    
    titleLabelFrame.size.width = CGRectGetWidth(self.bounds);
    titleLabelFrame.origin.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(titleLabelFrame))/2;
    titleLabelFrame.origin.y = CGRectGetMaxY(imageViewFrame)+self.lineSpacing;

    self.titleLabel.frame = titleLabelFrame;
    self.imageView.frame = imageViewFrame;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _badgeButton.imageView || object == _badgeButton.titleLabel){
        [_badgeButton.imageView sizeToFit];
        [_badgeButton.titleLabel sizeToFit];
        
        _badgeButton.hidden = (!CGRectIsEmpty(_badgeButton.imageView.bounds) && !CGRectIsEmpty(_badgeButton.titleLabel.bounds));

        CGRect badgeBtnFrame;
        badgeBtnFrame.size.height = CGRectGetHeight(_badgeButton.imageView.bounds);
        if (CGRectGetHeight(_badgeButton.imageView.bounds) < CGRectGetHeight(_badgeButton.titleLabel.bounds)) {
            badgeBtnFrame.size.height = CGRectGetHeight(_badgeButton.titleLabel.bounds);
        }
        badgeBtnFrame.size.width = CGRectGetWidth(_badgeButton.imageView.bounds)+CGRectGetWidth(_badgeButton.titleLabel.bounds);

        if (CGRectGetWidth(badgeBtnFrame) < 17) {
            badgeBtnFrame.size.width = 17;
        }
        if (CGRectGetHeight(badgeBtnFrame) < 17) {
            badgeBtnFrame.size.height = 17;
        }

        badgeBtnFrame.origin.x = CGRectGetMaxX(self.imageView.frame)-CGRectGetWidth(badgeBtnFrame)/2;
        badgeBtnFrame.origin.y = CGRectGetMinY(self.imageView.frame)-CGRectGetHeight(badgeBtnFrame)/2;
        _badgeButton.layer.cornerRadius = CGRectGetHeight(badgeBtnFrame)/2;

        _badgeButton.frame = badgeBtnFrame;
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(_badgeButton.frame, point)) {
        return _badgeButton;
    }
    return [super hitTest:point withEvent:event];
}
-(void)dealloc{
    [_badgeButton.titleLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(text))];
    [_badgeButton.imageView removeObserver:self forKeyPath:NSStringFromSelector(@selector(image))];
}

@end
