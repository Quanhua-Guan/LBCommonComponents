//
//  LBPlaceholderTextView.h
//  TransitBox
//
//  Created by 刘彬 on 2019/4/29.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LBTextViewTextField;
@interface LBPlaceholderTextView : UITextView
@property(nonatomic,readonly,strong)LBTextViewTextField *placeholderTextField;
@property(nonatomic)UITextFieldViewMode clearButtonMode;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,assign)NSInteger maxLength;
@end

NS_ASSUME_NONNULL_END
