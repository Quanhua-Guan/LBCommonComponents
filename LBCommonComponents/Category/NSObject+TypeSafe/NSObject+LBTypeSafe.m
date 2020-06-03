//
//  NSObject+LBTypeSafe.m
//  fachan
//
//  Created by 刘彬 on 2019/11/26.
//  Copyright © 2019 Swartz. All rights reserved.
//

#import "NSObject+LBTypeSafe.h"

@implementation NSObject (LBTypeSafe)
-(NSString *)safeString{
    return [self isKindOfClass:NSString.self]?(NSString *)self:nil;
}

-(NSMutableString *)safeMutableString{
    return [self isKindOfClass:NSMutableString.self]?(NSMutableString *)self:nil;
}

-(NSArray *)safeArray{
    return [self isKindOfClass:NSArray.self]?(NSArray *)self:nil;
}

-(NSMutableArray *)safeMutableArray{
    return [self isKindOfClass:NSMutableArray.self]?(NSMutableArray *)self:nil;
}

-(NSDictionary *)safeDictionary{
    return [self isKindOfClass:NSDictionary.self]?(NSDictionary *)self:nil;
}

-(NSMutableDictionary *)safeMutableDictionary{
    return [self isKindOfClass:NSMutableDictionary.self]?(NSMutableDictionary *)self:nil;
}

-(NSDate *)safeDate{
    return [self isKindOfClass:NSDate.self]?(NSDate *)self:nil;
}

-(NSMutableData *)safeMutableData{
    return [self isKindOfClass:NSMutableData.self]?(NSMutableData *)self:nil;
}

@end
