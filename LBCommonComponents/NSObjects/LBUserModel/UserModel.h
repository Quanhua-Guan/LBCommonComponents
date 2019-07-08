//
//  LoginInfo.h
//  MBP_MAPP
//
//  Created by 刘彬 on 16/4/19.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const QHToken;//登录token
extern NSString *const QHAccount;


typedef NS_ENUM(NSUInteger, MBFunctionType) {
    MBFunctionNone = 0,
};
@interface UserModel : NSObject
//用户登录信息
@property(nonatomic,readonly,strong)NSDictionary *userInfo;

- (void)setObject:(id)anObject forKey:(id)aKey;
- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
- (void)removeAllObjects;
- (void)removeObjectForKey:(id)aKey;
- (void)removeObjectsForKeys:(NSArray*)keyArray;

+(UserModel *)shareInstanse;
- (void)removeUserInfo;
@end
