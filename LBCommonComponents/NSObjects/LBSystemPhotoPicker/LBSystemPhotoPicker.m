//
//  LBSystemPhotoPicker.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/26.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBSystemPhotoPicker.h"


@interface LBSystemPhotoPicker()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak)UIViewController *viewController;
@property (nonatomic,strong)UIAlertController *imagePickerActionsheet;
@end
@implementation LBSystemPhotoPicker
- (instancetype)init
{
    self = [super init];
    if (self) {
        _imagePickerActionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [_imagePickerActionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
    }
    return self;
}
-(void)addImagePickerSourceType:(UIImagePickerControllerSourceType)sourceType title:(NSString *)title{
    __weak typeof(self) weakSelf = self;
    [self.imagePickerActionsheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                weakSelf.didFinishPickingMedia?
                weakSelf.didFinishPickingMedia(nil,@"您的设备不支持相册"):NULL;
                return;
            }else if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized && [PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusNotDetermined){
                weakSelf.didFinishPickingMedia?
                weakSelf.didFinishPickingMedia(nil,@"相册权限受限,请在隐私设置中启用相册访问"):NULL;
                return;
            }
        }
        
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                weakSelf.didFinishPickingMedia?
                weakSelf.didFinishPickingMedia(nil,@"您的设备不支持相机"):NULL;
                return;
            }else if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] != AVAuthorizationStatusAuthorized && [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] !=  AVAuthorizationStatusNotDetermined) {
                weakSelf.didFinishPickingMedia?
                weakSelf.didFinishPickingMedia(nil,@"相机调用受限,请在隐私设置中启用相机访问"):NULL;
                return;
            }
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = sourceType;
        [weakSelf.viewController presentViewController:imagePicker animated:YES completion:NULL];

    }]];
}
-(void)showInViewController:(UIViewController *)viewController{
    _viewController = viewController;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:weakSelf.imagePickerActionsheet animated:YES completion:NULL];
    });
}

#pragma mark PhotoSelectButtonDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.didFinishPickingMedia?
    self.didFinishPickingMedia(info,nil):NULL;
    
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    NSData * imageData = UIImageJPEGRepresentation(image,1.0);
    //    while ([imageData length]/1024 > 400) {
    //        imageData = UIImageJPEGRepresentation([UIImage imageWithData:imageData], 0.1);
    //    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
