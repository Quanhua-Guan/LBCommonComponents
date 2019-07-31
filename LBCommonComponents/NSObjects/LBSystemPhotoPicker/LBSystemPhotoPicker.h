//
//  LBSystemPhotoPicker.h
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/26.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface LBSystemPhotoPicker : NSObject
@property (nonatomic,copy)void (^didFinishPickingMedia)(NSDictionary * _Nullable info,NSString * _Nullable errorDesc);
-(void)addImagePickerSourceType:(UIImagePickerControllerSourceType )sourceType title:(NSString *)title;
-(void)showInViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
