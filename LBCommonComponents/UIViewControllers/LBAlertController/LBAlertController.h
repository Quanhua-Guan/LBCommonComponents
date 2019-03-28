//
//  MBAlertController.h
//  mbp_purse
//
//  Created by 刘彬 on 16/7/15.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBAlertUserViewProtocol <NSObject>
@required
@property (nonatomic,strong)NSDictionary *userInfo;
@end

@interface LBAlertActionButton : UIButton
@property (nonatomic,copy)void (^action)(UIButton *sender);
- (instancetype)initWithFrame:(CGRect)frame action:(void (^)(UIButton *sender))action;
@end

typedef void(^LBAlertAction)(UIButton *sender,NSDictionary *userInfo);
@interface LBAlertController : UIViewController
@property (nonatomic,strong,readonly)UILabel *alertTitleLabel;
@property (nonatomic,strong,readonly)UILabel *alertMessageLabel;
@property (nonatomic,strong)UIView<LBAlertUserViewProtocol> *userView;
@property (nonatomic,assign)NSTextAlignment messageTextAlignment;

@property (nonatomic,copy) NSString *alertTitle;
@property (nonatomic,copy) NSString *alertMessage;

@property (nonatomic,strong,readonly)NSMutableArray<LBAlertActionButton *> *buttonArray;


- (nonnull instancetype)initWithAlertTitle:(nullable NSString*)title message:(nullable NSString *)message;

-(void)addActionButton:(LBAlertActionButton *)actionButton;
@end
