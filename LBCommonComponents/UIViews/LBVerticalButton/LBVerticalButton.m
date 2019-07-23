//
//  LBVerticalButton.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/23.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBVerticalButton.h"

@interface LBVerticalButton()
@property (nonatomic,strong)UILabel *badgeNumberLabel;

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
        
        [self.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        
        self.lineSpacing = 5;
        
        self.badgeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        self.badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeNumberLabel.hidden = YES;
        self.badgeNumberLabel.clipsToBounds = YES;
        self.badgeNumberLabel.font = [UIFont systemFontOfSize:11];
        self.badgeNumberLabel.textColor = [UIColor whiteColor];
        self.badgeNumberLabel.backgroundColor = [UIColor redColor];
        self.badgeNumberLabel.layer.cornerRadius = CGRectGetHeight(self.badgeNumberLabel.frame)/2;
        [self addSubview:self.badgeNumberLabel];
    }
    return self;
}
-(void)setIconBadgeNumber:(NSUInteger)iconBadgeNumber{
    _iconBadgeNumber = iconBadgeNumber;
    self.badgeNumberLabel.hidden = !iconBadgeNumber;
    
    NSString *iconBadgeNumberString = [NSString stringWithFormat:@"%ld",iconBadgeNumber];
    if (iconBadgeNumber > 99) {
        iconBadgeNumberString = @"99+";
    }
    self.badgeNumberLabel.text = iconBadgeNumberString;
    
    CGSize iconBadgeNumberSize = [self.badgeNumberLabel sizeThatFits:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.badgeNumberLabel.frame))];
    if (iconBadgeNumberSize.width > CGRectGetHeight(self.badgeNumberLabel.frame)) {
        self.badgeNumberLabel.frame = CGRectMake(CGRectGetMinX(self.badgeNumberLabel.frame), CGRectGetMinY(self.badgeNumberLabel.frame), iconBadgeNumberSize.width, CGRectGetHeight(self.badgeNumberLabel.frame));
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.imageView) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]){
            self.imageEdgeInsets = UIEdgeInsetsMake(CGRectGetHeight(self.frame)/2-CGRectGetHeight(self.imageView.frame)-self.lineSpacing/2, (CGRectGetWidth(self.frame)-CGRectGetWidth(self.imageView.frame))/2, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(CGRectGetHeight(self.frame)/2+self.lineSpacing/2, (CGRectGetWidth(self.frame)-[self.titleLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), 30)].width)/2-CGRectGetWidth(self.imageView.frame), 0, 0);
            
            
            
            self.badgeNumberLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)-CGRectGetWidth(self.badgeNumberLabel.frame)/2, CGRectGetMinY(self.imageView.frame)-CGRectGetHeight(self.badgeNumberLabel.frame)/2, CGRectGetWidth(self.badgeNumberLabel.frame), CGRectGetHeight(self.badgeNumberLabel.frame));
        }
    }
    
}
@end
