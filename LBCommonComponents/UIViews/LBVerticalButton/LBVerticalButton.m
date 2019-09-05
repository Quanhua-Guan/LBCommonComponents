//
//  LBVerticalButton.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/23.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBVerticalButton.h"

@interface LBVerticalButton()
@property (nonatomic,strong)NSString *badgeButtonBoundsString;
@property (nonatomic,strong)NSString *imageViewBoundsString;
@property (nonatomic,strong)NSString *titleLabelBoundsString;
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
        
        [_badgeButton addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionNew context:nil];

        [self.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionNew context:nil];
        [self.titleLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageViewFrame = _imageViewBoundsString?CGRectFromString(_imageViewBoundsString):self.imageView.frame;
    CGRect titleLabelFrame = _titleLabelBoundsString?CGRectFromString(_titleLabelBoundsString):self.titleLabel.frame;
    CGFloat minY = (CGRectGetHeight(self.bounds)-(CGRectGetHeight(titleLabelFrame)+CGRectGetHeight(imageViewFrame)+self.lineSpacing))/2;
    imageViewFrame.origin.y = minY;
    imageViewFrame.origin.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(imageViewFrame))/2;
    
    titleLabelFrame.size.width = CGRectGetWidth(self.bounds);
    titleLabelFrame.origin.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(titleLabelFrame))/2;
    titleLabelFrame.origin.y = CGRectGetMaxY(imageViewFrame)+self.lineSpacing;

    self.titleLabel.frame = titleLabelFrame;
    self.imageView.frame = imageViewFrame;
    
    CGRect badgeButtonBounds = CGRectFromString(self.badgeButtonBoundsString);
    _badgeButton.layer.cornerRadius = CGRectGetHeight(badgeButtonBounds)/2;

    self.badgeButton.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)-CGRectGetWidth(badgeButtonBounds)/2, CGRectGetMinY(self.imageView.frame)-CGRectGetHeight(badgeButtonBounds)/2, CGRectGetWidth(badgeButtonBounds), CGRectGetHeight(badgeButtonBounds));
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

        if (!_badgeButtonBoundsString) {
            _badgeButtonBoundsString = NSStringFromCGRect(CGRectMake(0, 0, CGRectGetWidth(badgeBtnFrame), CGRectGetHeight(badgeBtnFrame)));
        }
        [self setNeedsLayout];
    }else if ([object isEqual:_badgeButton]){
        if (!_badgeButtonBoundsString) {
            _badgeButtonBoundsString = NSStringFromCGRect(_badgeButton.frame);
        }
    }else if ([object isEqual:self.imageView]){
        if (!_imageViewBoundsString) {
            _imageViewBoundsString = NSStringFromCGRect(self.imageView.frame);
        }
    }else if ([object isEqual:self.titleLabel]){
        if (!_titleLabelBoundsString) {
            _titleLabelBoundsString = NSStringFromCGRect(self.titleLabel.frame);
        }
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
    [_badgeButton removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
    [self.imageView removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
    [self.titleLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
}

@end
