//
//  LunarFormatter.h
//  FSCalendar
//
//  Created by Wenchao Ding on 25/07/2017.
//  Copyright © 2017 wenchaoios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBLunarFormatter : NSObject
@property (strong, nonatomic,readonly) NSCalendar *chineseCalendar;
@property (strong, nonatomic,readonly) NSArray<NSString *> *chineseMonths;
@property (strong, nonatomic,readonly) NSArray<NSString *> *chineseWeekDays;
@property (strong, nonatomic,readonly) NSArray<NSString *> *chineseMonthDays;

@property (strong, nonatomic,readonly) NSArray<NSString *> *chineseGanZiYears;
@property (strong, nonatomic,readonly) NSDictionary<NSString *,NSArray *> *chineseGanZiMonths;//key为干支年
@property (strong, nonatomic,readonly) NSArray<NSString *> *chineseGanZiDays;
@property (strong, nonatomic,readonly) NSDictionary<NSString *,NSString *> *chineseZodiac;

-(NSString *)chineseFirstDayIsMonthDayOfDate:(NSDate *)date;

-(NSString *)chineseDayOfDate:(NSDate *)date;

-(NSString *)chineseMonthOfDate:(NSDate *)date;

-(NSString *)chineseWeekDayOfDate:(NSDate *)date;

-(NSString *)chineseGanZiYearOfDate:(NSDate *)date;

-(NSString*)chineseGanZiMonthOfDate:(NSDate *)date;

-(NSString *)chineseGanZiDayOfDate:(NSDate *)date;

-(NSString *)chineseZodiacOfDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
