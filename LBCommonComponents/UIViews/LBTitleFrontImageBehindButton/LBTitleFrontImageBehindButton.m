//
//  LBTitleFrontImageBehindButton.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/8/14.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBTitleFrontImageBehindButton.h"

@implementation LBTitleFrontImageBehindButton
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.spacing = 5;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect titleLabelFrame = self.titleLabel.frame;
    CGRect imageViewFrame = self.imageView.frame;
    CGFloat minX = (CGRectGetWidth(self.bounds)-(CGRectGetWidth(titleLabelFrame)+CGRectGetWidth(imageViewFrame)+self.spacing))/2;
    titleLabelFrame.origin.x = minX;
    imageViewFrame.origin.x = CGRectGetMaxX(titleLabelFrame)+self.spacing;
    self.titleLabel.frame = titleLabelFrame;
    self.imageView.frame = imageViewFrame;
}
@end
