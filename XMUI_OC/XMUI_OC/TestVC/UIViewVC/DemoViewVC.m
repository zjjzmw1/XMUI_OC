//
//  DemoViewVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import "DemoViewVC.h"
#import "UIView+XMRotate360.h"

@interface DemoViewVC ()

@property (nonatomic, strong) UIView    *view1;
@property (nonatomic, strong) UIView    *view2;


@end

@implementation DemoViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"UIView类目"];

    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 150, 100)];
    self.view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.view1];
    // 旋转动画
    [self.view1 xmRotate360WithDuration:2.0 repeatCount:CGFLOAT_MAX timingMode:XMRotate360TimingModeEaseInEaseOut];
    
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(50, self.view1.bottom + 100, 150, 100)];
    self.view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.view2];
    // 旋转动画
    [self.view2 xmRotate360WithDuration:2.0 repeatCount:CGFLOAT_MAX timingMode:XMRotate360TimingModeLinear];


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
