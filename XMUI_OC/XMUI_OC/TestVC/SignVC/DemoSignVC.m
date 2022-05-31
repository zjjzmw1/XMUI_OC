//
//  DemoSignVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import "DemoSignVC.h"
#import "XMSignView.h"

@interface DemoSignVC ()

@end

@implementation DemoSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"签名"];
    
    XMSignView *signatureView = [[XMSignView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth_XM - 20, 104)];
   // [signatureView setCallbackImageUrl:@"https://alifei03.cfp.cn/creative/vcg/veer/1600water/veer-373869702.jpg"];
    signatureView.backgroundColor = [UIColor blueColor];
//    signatureView.isEdit = NO;
    NSLog(@"当前的image %@", signatureView.callbackImage);
    
    signatureView.imageDataBlock = ^(XMSignView *signatureView,UIImage * _Nonnull image) {
        NSLog(@"实时变化的image %@", image);
    };
    
    signatureView.onClickViewBlock = ^(BOOL isWillState) {
        if (!isWillState) {

            
        } else {
            // 画布消失，此时要旋转成竖屏
        }
    };
    [self.view addSubview:signatureView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
