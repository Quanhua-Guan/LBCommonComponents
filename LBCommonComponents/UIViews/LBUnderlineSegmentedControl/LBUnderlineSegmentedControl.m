//
//  TitleSwitchView.m
//  operator
//
//  Created by 刘彬 on 2019/1/11.
//  Copyright © 2019 张琛. All rights reserved.
//

#import "LBUnderlineSegmentedControl.h"

@interface LBUnderlineSegmentedButton : UIButton
@property (nonatomic,strong)UIView *newsPoint;
@property (nonatomic) CGFloat lineHeight;
@property (nonatomic,strong)UIView *underLineView;
@end
@implementation LBUnderlineSegmentedButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineHeight = 3;
        
        _newsPoint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        _newsPoint.layer.cornerRadius = CGRectGetHeight(_newsPoint.frame)/2;
        _newsPoint.backgroundColor = [UIColor redColor];
        _newsPoint.clipsToBounds = YES;
        _newsPoint.hidden = YES;
        [self addSubview:_newsPoint];
        [self addObserver:self forKeyPath:@"titleLabel.frame" options:NSKeyValueObservingOptionNew context:nil];
        
        _underLineView = [[UIView alloc] init];
        [self addSubview:_underLineView];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"titleLabel.frame"]) {
        _newsPoint.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)-CGRectGetWidth(_newsPoint.frame)/2, CGRectGetMinY(self.titleLabel.frame)-CGRectGetHeight(_newsPoint.frame)/2, CGRectGetWidth(_newsPoint.frame), CGRectGetHeight(_newsPoint.frame));
        
        _underLineView.frame = CGRectMake(self.titleLabel.center.x-CGRectGetWidth(self.titleLabel.frame)/2, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.frame), _lineHeight);
    }
}

-(void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    [self observeValueForKeyPath:@"titleLabel.frame" ofObject:self change:nil context:nil];
}
@end


@interface LBUnderlineSegmentedControl ()
@property (nonatomic,strong)NSMutableArray<LBUnderlineSegmentedButton *> *privateItemsBtnArray;
@property (nonatomic,copy)void (^itemSeletedBlock)(__weak UIButton *sliderButton);
@end
@implementation LBUnderlineSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items action:(void (^ _Nullable)(__weak UIButton *sliderButton))action
{
    self = [super initWithFrame:frame];
    if (self) {
        _font = [UIFont systemFontOfSize:14];
        _privateItemsBtnArray = [NSMutableArray array];
        _itemSeletedBlock = action;
        
        typeof(self) __weak weakSelf = self;
        typeof(items) __weak weakItems = items;
        [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LBUnderlineSegmentedButton *itemsBtn = [[LBUnderlineSegmentedButton alloc] initWithFrame:CGRectMake(idx*(CGRectGetWidth(frame)/weakItems.count), 0, CGRectGetWidth(frame)/weakItems.count, CGRectGetHeight(frame))];
            itemsBtn.titleLabel.font = weakSelf.font;
            itemsBtn.underLineView.hidden = YES;
            [itemsBtn setTitle:obj forState:UIControlStateNormal];
            [itemsBtn addTarget:weakSelf action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf addSubview:itemsBtn];
            [weakSelf.privateItemsBtnArray addObject:itemsBtn];
        }];
        _itemsBtnArray = [NSArray arrayWithArray:_privateItemsBtnArray];
        
        _sliderButton = [[LBUnderlineSegmentedButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)/items.count, CGRectGetHeight(frame))];
        _sliderButton.userInteractionEnabled = NO;
        [self addSubview:_sliderButton];
        
        [self setSelectedSegmentIndex:0];
    }
    return self;
}
-(void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    [(LBUnderlineSegmentedButton *)_sliderButton setLineHeight:_lineHeight];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    _sliderButton.backgroundColor = self.backgroundColor;
}
-(void)setUnderlineColor:(UIColor *)underlineColor{
    _underlineColor = underlineColor;
    ((LBUnderlineSegmentedButton *)_sliderButton).underLineView.backgroundColor = underlineColor;
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:textColor forState:UIControlStateNormal];
    }];
}
-(void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    [_sliderButton setTitleColor:selectedTextColor forState:UIControlStateNormal];
}
-(void)setFont:(UIFont *)font{
    _font = font;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font = font;
    }];
    _sliderButton.titleLabel.font = font;
}
-(void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    _selectedSegmentIndex = selectedSegmentIndex;
    
    LBUnderlineSegmentedButton *itmeBtn = [self.privateItemsBtnArray objectAtIndex:selectedSegmentIndex];
    [self.sliderButton setTitle:[itmeBtn titleForState:UIControlStateNormal] forState:UIControlStateNormal];
    self.itemSeletedBlock?self.itemSeletedBlock(self.sliderButton):NULL;
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.sliderButton.center = CGPointMake(itmeBtn.center.x, weakSelf.sliderButton.center.y);
        ((LBUnderlineSegmentedButton *)weakSelf.sliderButton).newsPoint.hidden = itmeBtn.newsPoint.hidden;
    } completion:NULL];
}
-(void)setNews:(BOOL)showNews forSegmentIndex:(NSInteger)selectedSegmentIndex{
    [_privateItemsBtnArray objectAtIndex:selectedSegmentIndex].newsPoint.hidden = !showNews;
}

-(void)itemSelected:(LBUnderlineSegmentedButton *)sender{
    [self setSelectedSegmentIndex:[_privateItemsBtnArray indexOfObject:sender]];
    typeof(self) __weak weakSelf = self;
    _itemSeletedBlock?_itemSeletedBlock(weakSelf.sliderButton):NULL;
}
@end
