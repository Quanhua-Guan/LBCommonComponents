//
//  DatePickerViewController.h
//  QHBranch
//
//  Created by 刘彬 on 2018/12/27.
//  Copyright © 2018 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBYearMonthPickerVC : UIViewController
@property (nonatomic,copy)void(^pickerViewSelectDate)(NSString * _Nonnull yearString,NSString * _Nonnull monthString);
@property (nonatomic,strong)NSDictionary<NSNumber */*index*/,NSDictionary<NSString *,NSArray *> *> *defaultLikeYearsAndMonths;//默认要添加的年份以及该年份对应的月比如：@{@(0):@{@"全部年":@[@"3",@"5"]}}};(在第一个添加了全部年的3月和五月，key是负数的话将添加到最后一个)
@property (nonatomic,strong)NSDictionary<NSNumber */*index*/,NSString *> *eachYearDefaultLikeMonths;//每年的月份里面默认要添加的项比如：@{@(0):@"全部月"}；（在每年的所有月份前添加了全部月，key是负数的话将添加到最后一个）
@property (nonatomic,strong)NSDate *minDate;
@property (nonatomic,strong)NSDate *selectedDate;
@property (nonatomic,strong)NSString *selectedDateString;
@end

NS_ASSUME_NONNULL_END
