//
//  LBTableViewCell.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/8/2.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBTableViewCell.h"
@interface LBTableViewCell ()
@property (nonatomic,assign)CGRect imageFrame;
@property (nonatomic,assign)CGFloat imageViewCornerRadius;
@property (nonatomic,assign)CGRect textLabelFrame;
@property (nonatomic,assign)CGRect detailTextLabelFrame;
@property (nonatomic,assign)NSTextAlignment textLabelTextAlignment;
@property (nonatomic,assign)NSTextAlignment detailTextLabelTextAlignment;
@property (nonatomic,assign)dispatch_once_t imageViewFrameOnceToken;
@property (nonatomic,assign)dispatch_once_t imageViewLayerOnceToken;
@property (nonatomic,assign)dispatch_once_t textLabelOnceToken;
@property (nonatomic,assign)dispatch_once_t detailTextLabelOnceToken;
@property (nonatomic,assign)dispatch_once_t textLabelAlignmentOnceToken;
@property (nonatomic,assign)dispatch_once_t detailTextLabelAlignmentOnceToken;
@end
@implementation LBTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        [self.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:[NSString stringWithFormat:@"%@.%@",NSStringFromSelector(@selector(layer)),NSStringFromSelector(@selector(cornerRadius))] options:NSKeyValueObservingOptionNew context:nil];
        [self.textLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        [self.detailTextLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        [self.textLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(textAlignment)) options:NSKeyValueObservingOptionNew context:nil];
        [self.detailTextLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(textAlignment)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = _imageFrame;
    self.imageView.layer.cornerRadius = _imageViewCornerRadius;
    self.textLabel.frame = _textLabelFrame;
    self.detailTextLabel.frame = _detailTextLabelFrame;
    self.textLabel.textAlignment = _textLabelTextAlignment;
    self.detailTextLabel.textAlignment = _detailTextLabelTextAlignment;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    __weak typeof(self) weakSelf = self;
    if (object == self.imageView) {
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            dispatch_once(&_imageViewFrameOnceToken, ^{
                weakSelf.imageFrame = self.imageView.frame;
            });
        }else if ([keyPath isEqualToString:[NSString stringWithFormat:@"%@.%@",NSStringFromSelector(@selector(layer)),NSStringFromSelector(@selector(cornerRadius))]]){
            dispatch_once(&_imageViewLayerOnceToken, ^{
                weakSelf.imageViewCornerRadius = self.imageView.layer.cornerRadius;
            });
        }
        
    }else if (object == self.textLabel){
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            dispatch_once(&_textLabelOnceToken, ^{
                weakSelf.textLabelFrame = self.textLabel.frame;
                
            });
        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(textAlignment))]){
            dispatch_once(&_textLabelAlignmentOnceToken, ^{
                weakSelf.textLabelTextAlignment = self.textLabel.textAlignment;
            });
        }
        
    }else if (object == self.detailTextLabel){
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            dispatch_once(&_detailTextLabelOnceToken, ^{
                weakSelf.detailTextLabelFrame = self.detailTextLabel.frame;
            });
        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(textAlignment))]){
            dispatch_once(&_detailTextLabelAlignmentOnceToken, ^{
                weakSelf.detailTextLabelTextAlignment = self.detailTextLabel.textAlignment;
                
            });
        }
    }
}

@end
