//
//  LBRichTextView.h
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/18.
//  Copyright © 2019 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark 协议
//自定义view协议
@protocol LBTextAttachmentViewProtocol <NSObject>
@required
/*自定义View携带的内容data，它将被作为唯一标识类似于ID使用*/
@property (nonatomic,strong)NSData *contens;
@optional
@property (nonatomic,strong)NSParagraphStyle *paragraphStyle;
@end

//富文本对象协议
@protocol LBRichTextProtocol <NSObject>
//attachmentView优先使用，也就是当attachmentView不为空的时候attributedString无效。
//属性必须有一个不为空
@required
@property (nonatomic,strong)NSAttributedString *attributedString;
@property (nonatomic,strong)UIView<LBTextAttachmentViewProtocol> *attachmentView;
@end


#pragma mark 自定义便利View,你不是必须用该类，只是提供给我们比较懒的程序员用
@interface LBTextAttachmentView : UIButton<LBTextAttachmentViewProtocol>
@property (nonatomic,strong)NSData *contens;
@property (nonatomic,strong)NSParagraphStyle *paragraphStyle;
@end

/*你不是必须用该类，只是提供一个便利类以在你不想创建自己的类的时候用*/
@interface LBRichTextObject : NSObject<LBRichTextProtocol>
@property (nonatomic,strong)NSAttributedString *attributedString;
@property (nonatomic,strong)UIView<LBTextAttachmentViewProtocol> *attachmentView;
@end

#pragma mark

@interface LBRichTextView : UITextView
@property (nonatomic,strong)NSMutableArray<NSObject<LBRichTextProtocol> *> *richTextArray;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
