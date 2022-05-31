//
//  XMSignView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 签名view
@interface XMSignView : UIView

@property (nonatomic, strong) UIImage *callbackImage;
@property (nonatomic, strong) void (^imageDataBlock)(XMSignView *, UIImage *image);
@property (nonatomic, strong) void (^onClickViewBlock)(BOOL isWillState);//弹出的视图显示状态 NO 未显示， YES显示

- (void)setCallbackImageUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
