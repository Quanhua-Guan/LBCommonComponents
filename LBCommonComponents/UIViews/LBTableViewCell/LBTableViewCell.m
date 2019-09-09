//
//  LBTableViewCell.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/8/2.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBTableViewCell.h"
@interface LBTableViewCell ()
@property (nonatomic,strong)NSString *imageFrameString;
@property (nonatomic,strong)NSNumber *imageViewCornerRadius;
@property (nonatomic,strong)NSString *textLabelFrameString;
@property (nonatomic,strong)NSString *detailTextLabelFrameString;
@property (nonatomic,strong)NSNumber *textLabelTextAlignment;
@property (nonatomic,strong)NSNumber *detailTextLabelTextAlignment;
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
    self.imageView.frame = CGRectFromString(_imageFrameString);
    self.imageView.layer.cornerRadius = _imageViewCornerRadius.floatValue;
    self.textLabel.frame = CGRectFromString(_textLabelFrameString);
    self.detailTextLabel.frame = CGRectFromString(_detailTextLabelFrameString);
    self.textLabel.textAlignment = _textLabelTextAlignment.integerValue;
    self.detailTextLabel.textAlignment = _detailTextLabelTextAlignment.integerValue;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.imageView) {
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            if (!_imageFrameString) {
                _imageFrameString = NSStringFromCGRect(self.imageView.frame);
            }
        }else if ([keyPath isEqualToString:[NSString stringWithFormat:@"%@.%@",NSStringFromSelector(@selector(layer)),NSStringFromSelector(@selector(cornerRadius))]]){
            if (!_imageViewCornerRadius) {
                _imageViewCornerRadius = @(self.imageView.layer.cornerRadius);
            }
        }
        
    }else if (object == self.textLabel){
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            if (!_textLabelFrameString) {
                _textLabelFrameString = NSStringFromCGRect(self.textLabel.frame);
            }
        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(textAlignment))]){
            if (!_textLabelTextAlignment) {
                _textLabelTextAlignment = @(self.textLabel.textAlignment);
            }
        }
        
    }else if (object == self.detailTextLabel){
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            if (!_detailTextLabelFrameString) {
                _detailTextLabelFrameString = NSStringFromCGRect(self.detailTextLabel.frame);
            }
        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(textAlignment))]){
            if (!_detailTextLabelTextAlignment) {
                _detailTextLabelTextAlignment = @(self.detailTextLabel.textAlignment);
            }
        }
    }
}

-(void)dealloc{
    [self.imageView removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
    [self.imageView removeObserver:self forKeyPath:[NSString stringWithFormat:@"%@.%@",NSStringFromSelector(@selector(layer)),NSStringFromSelector(@selector(cornerRadius))]];
    [self.textLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
    [self.textLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(textAlignment))];
    [self.detailTextLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
    [self.detailTextLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(textAlignment))];
}

@end
