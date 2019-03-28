//
//  MBAlertController.h
//  mbp_purse
//
//  Created by 刘彬 on 16/7/15.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBAlertUserViewProtocol <NSObject>
@optional
@property (nonatomic,strong,nullable)NSDictionary *userInfo;
@end

@interface LBAlertActionButton : UIButton
@property (nonatomic,copy)void (^_Nullable action)(UIButton *_Nonnull sender);
- (instancetype _Nonnull)initWithFrame:(CGRect)frame action:(void (^_Nullable)(UIButton *_Nonnull sender))action;
@end

@interface LBAlertController : UIViewController
@property (nonatomic,strong,readonly,nonnull)UILabel *alertTitleLabel;
@property (nonatomic,strong,readonly,nonnull)UILabel *alertMessageLabel;
@property (nonatomic,strong,nullable)UIView<LBAlertUserViewProtocol> *userView;
@property (nonatomic,assign)NSTextAlignment messageTextAlignment;

@property (nonatomic,copy,nullable) NSString *alertTitle;
@property (nonatomic,copy,nullable) NSString *alertMessage;

@property (nonatomic,strong,readonly,nullable)NSMutableArray<LBAlertActionButton *> *buttonArray;


- (nonnull instancetype)initWithAlertTitle:(nullable NSString*)title message:(nullable NSString *)message;

-(void)addActionButton:(LBAlertActionButton *_Nonnull)actionButton;
@end
