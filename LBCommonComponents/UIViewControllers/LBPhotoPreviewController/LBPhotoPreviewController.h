//
//  LBPhotoPreviewController.h
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/18.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LBImageProtocol <NSObject>
@required
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSURL *imageUrl;
@end

@interface LBImageObject : NSObject<LBImageProtocol>
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSURL *imageUrl;
@end

@interface LBPhotoPreviewController : UIViewController
@property (nonatomic, assign)BOOL canDeletePhoto;
@property (nonatomic, strong) NSMutableArray<NSObject<LBImageProtocol> *> * imageObjectArray;
@property (nonatomic, copy) void(^assetDeleteHandler)(NSObject<LBImageProtocol> *imageObject);

@end

NS_ASSUME_NONNULL_END
