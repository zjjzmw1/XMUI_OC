//
//  XMUploadProgressView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    XMUploadProgressStatusNone      =   0,
    XMUploadProgressStatusLoading   =   1,
    XMUploadProgressStatusError     =   2,
    XMUploadProgressStatusSuccess   =   3,
}XMUploadProgressStatus;

/// 上传进度的自定义view
@interface XMUploadProgressView : UIView

/// 删除图片的回调 「这里包含了删除逻辑，block只是告诉使用者：删除成功了，可以做相关的业务处理」
@property (nonatomic, copy) void (^deleteImageSuccessBlock) (void);

/// 刷新数据
/// @param status 上传图片的状态
/// @param selectImage 当前选择的图片，未上传： nil
- (void)reloadDataWithStatus:(XMUploadProgressStatus)status selectImage:(nullable UIImage *)selectImage;

@end

NS_ASSUME_NONNULL_END
