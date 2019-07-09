//
//  LoginInfo.m
//  MBP_MAPP
//
//  Created by 刘彬 on 16/4/19.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "UserModel.h"
NSString *const QHUserInfo = @"QHUserInfo";//私有

NSString *const QHToken = @"QHToken";
NSString *const QHAccount = @"QHAccount";

@interface UserModel()
@property (nonatomic,strong)NSMutableDictionary *privateUserInfo;
@end

@implementation UserModel
+(UserModel *)shareInstanse{
    static UserModel *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[UserModel alloc] init];
    });
    return info;
}

-(NSDictionary *)userInfo{
    if (_privateUserInfo) {
        return _privateUserInfo;
    }else{
        _privateUserInfo = [[[NSUserDefaults standardUserDefaults] objectForKey:QHUserInfo] mutableCopy];
        if (!_privateUserInfo) {
            _privateUserInfo = [[NSMutableDictionary alloc] init];
        }
        return _privateUserInfo;
    }
    return _privateUserInfo;
}
- (void)setObject:(id)anObject forKey:(id)aKey{
    if ([anObject isEqual:[NSNull null]]) {
        anObject = @"";
    }
    [_privateUserInfo setValue:anObject forKey:aKey];
    [[NSUserDefaults standardUserDefaults] setObject:_privateUserInfo forKey:QHUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary{
    for (id key in otherDictionary.allKeys) {
        id anObject = otherDictionary[key];
        if ([anObject isEqual:[NSNull null]]) {
            anObject = @"";
        }
        [_privateUserInfo setValue:anObject forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_privateUserInfo forKey:QHUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeUserInfo{
    _privateUserInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:QHUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeAllObjects{
    [self removeObjectsForKeys:_privateUserInfo.allKeys];
}
- (void)removeObjectForKey:(id)aKey{
    [self removeObjectsForKeys:@[aKey]];
}

- (void)removeObjectsForKeys:(NSArray*)keyArray{
    [_privateUserInfo removeObjectsForKeys:keyArray];
    [[NSUserDefaults standardUserDefaults] setObject:_privateUserInfo forKey:QHUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
