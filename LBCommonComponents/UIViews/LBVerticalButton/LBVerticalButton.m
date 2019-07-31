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
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _lineSpacing = 5;
        
        _badgeButton = [[UIButton alloc] init];
        _badgeButton.hidden = YES;
        _badgeButton.clipsToBounds = YES;
        _badgeButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _badgeButton.backgroundColor = [UIColor redColor];
        [self addSubview:_badgeButton];
        
        [self.titleLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(text)) options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(image)) options:NSKeyValueObservingOptionNew context:nil];
        
        [_badgeButton.titleLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(text)) options:NSKeyValueObservingOptionNew context:nil];
        [_badgeButton.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(image)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.imageView || object == self.titleLabel) {
        if (self.imageView.image && self.titleLabel.text) {
            self.imageEdgeInsets = UIEdgeInsetsMake(CGRectGetHeight(self.frame)/2-CGRectGetHeight(self.imageView.frame)-self.lineSpacing/2, (CGRectGetWidth(self.frame)-CGRectGetWidth(self.imageView.frame))/2, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(CGRectGetHeight(self.frame)/2+self.lineSpacing/2, (CGRectGetWidth(self.frame)-[self.titleLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), 30)].width)/2-CGRectGetWidth(self.imageView.frame), 0, 0);
        }
    }else if (object == _badgeButton.imageView || object == _badgeButton.titleLabel){
        
        
        
        [_badgeButton sizeToFit];
        _badgeButton.hidden = (!CGRectIsEmpty(_badgeButton.imageView.bounds) && !CGRectIsEmpty(_badgeButton.titleLabel.bounds));
        
        
        CGSize iconBadgeBtnSize;
        if (!CGRectIsEmpty(_badgeButton.imageView.bounds) && CGRectIsEmpty(_badgeButton.titleLabel.bounds)) {
            iconBadgeBtnSize = CGSizeMake(CGRectGetWidth(_badgeButton.imageView.bounds), CGRectGetHeight(_badgeButton.imageView.bounds));
        }else if (!CGRectIsEmpty(_badgeButton.titleLabel.bounds) && CGRectIsEmpty(_badgeButton.imageView.bounds)){
            iconBadgeBtnSize = CGSizeMake(CGRectGetWidth(_badgeButton.titleLabel.bounds), CGRectGetHeight(_badgeButton.titleLabel.bounds));
        }else{
            iconBadgeBtnSize = [_badgeButton sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        }
        
        if (iconBadgeBtnSize.width < 17) {
            iconBadgeBtnSize.width = 17;
        }
        if (iconBadgeBtnSize.height < 17) {
            iconBadgeBtnSize.height = 17;
        }
        
        _badgeButton.frame = CGRectMake(0, 0, iconBadgeBtnSize.width, iconBadgeBtnSize.height);
        
        
        if (!CGRectIsEmpty(self.imageView.bounds)) {
            _badgeButton.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
        }else if (!CGRectIsEmpty(self.titleLabel.bounds)){
            _badgeButton.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
        }else{
            _badgeButton.center = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));
        }
        
        _badgeButton.layer.cornerRadius = CGRectGetHeight(_badgeButton.frame)/2;

    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(_badgeButton.frame, point)) {
        return _badgeButton;
    }
    return [super hitTest:point withEvent:event];
}
@end
