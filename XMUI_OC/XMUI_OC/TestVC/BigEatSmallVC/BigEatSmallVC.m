//
//  BigEatSmallVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/12.
//

#import "BigEatSmallVC.h"
#import <AVFoundation/AVFoundation.h>
#import "XMAlertView.h"

@interface BigEatSmallVC ()

/// 自己
@property (nonatomic, strong) UIImageView    *meImageView;
/// 自己的宽
@property (nonatomic, assign) CGFloat        meWidth;
/// 自己的高
@property (nonatomic, assign) CGFloat        meHeight;

/// 播放器
@property (nonatomic, strong) AVAudioPlayer  *movePlayer;
/// 定时器
@property (nonatomic, strong) NSTimer        *myTimer;

@end

@implementation BigEatSmallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    // 自己的宽高
    self.meWidth = 150;
    self.meHeight = 150;
    
    [self initAllView];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkMethod:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/// 横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

/// 初始化
- (void)initAllView {
    [self.view addSubview:self.meImageView];
    self.meImageView.frame = CGRectMake((kScreenWidth_XM - self.meWidth)/2.0, (kScreenHeight_XM - self.meHeight)/2.0, self.meWidth, self.meHeight);
    // 默认初始化多条鱼
    for (int i = 0; i < 110; i++) {
        [self initOtherViewAction];
    }
}

#pragma mark - 其他鱼从屏幕外面移动过来
/// 生成一个新鱼
- (void)initOtherViewAction {
    CGFloat tempWidth = arc4random()%150 + 30; // 30 -- 180 大小的鱼
    if (tempWidth > self.meWidth) {
        tempWidth = self.meWidth * 1.5;
    }
    CGFloat tempLeft = -tempWidth + arc4random()%300 - 400;
    CGFloat tempTop = arc4random()%((int)(kScreenHeight_XM - tempWidth));
    // 临时产生的鱼
    UIImageView *tempImgV = [[UIImageView alloc] initWithFrame:CGRectMake(tempLeft, tempTop, tempWidth, tempWidth)];
    tempImgV.backgroundColor = [UIColor clearColor];
    tempImgV.tag = 100 + arc4random()%10000;
    tempImgV.layer.masksToBounds = YES;
    tempImgV.layer.cornerRadius = tempWidth/2.0;
    // 判断相交就不初始化
    BOOL isMutul = NO;
    for (UIView *subV in self.view.subviews) {
        if (subV.tag >= 100) {
            isMutul = [self isInitMutulAction:tempImgV otherView:subV];
            if (isMutul) {
                break;
            }
        }
    }
    if (isMutul == NO) { // 不相交，才初始化
        [self.view addSubview:tempImgV];
        int fishInt = arc4random()%7 + 1;
        tempImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",fishInt]];
        if (tempWidth > self.meWidth) {
            tempImgV.image = [UIImage imageNamed:@"sha"];
        }
    } else {
        [tempImgV removeFromSuperview];
    }
}

#pragma mark - 手指拖动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint prePoint = [touch previousLocationInView:self.view];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    // 平移
//    self.meImageView.transform = CGAffineTransformTranslate(self.meImageView.transform, offsetX, offsetY);
    self.meImageView.frame = CGRectMake(self.meImageView.left + offsetX, self.meImageView.top + offsetY, self.meWidth, self.meHeight);
    // 处理边界值
    CGFloat lastLeft = self.meImageView.left;
    CGFloat lastTop = self.meImageView.top;
    if (self.meImageView.left < 0) {
        lastLeft = 0;
    }
    if (self.meImageView.top < 0) {
        lastTop = 0;
    }
    if (self.meImageView.left + self.meWidth > kScreenWidth_XM) {
        lastLeft = kScreenWidth_XM - self.meWidth;
    }
    if (self.meImageView.top + self.meHeight > kScreenHeight_XM) {
        lastTop = kScreenHeight_XM - self.meHeight;
    }
    self.meImageView.frame = CGRectMake(lastLeft, lastTop, self.meWidth, self.meHeight);

}

/// 判断两个view相交 --- 相交就被吃
- (BOOL)isMutulAction:(UIView *)originV otherView:(UIView *)otherV {
    // 判断矩形相交。
//    BOOL isMutul = CGRectIntersectsRect(originV.frame, otherV.frame);
    // 判断圆心距离
    BOOL isMutul = NO;
    CGFloat centerDistance = [self getDistanceFromCenter:originV otherView:otherV];
    if (centerDistance < (originV.width + otherV.width)/2.0) {
        isMutul = YES;
    }
    if (isMutul) { // 相交了
        if (originV.width * originV.height  > otherV.width * otherV.height) {
            [otherV removeFromSuperview];
            [self initOtherViewAction];
            [self playSoundAction:@"1.mp3"];
        } else {
            [originV removeFromSuperview];
            for (UIView *subV in self.view.subviews) {
                [subV removeFromSuperview];
            }
            __weak typeof(self) weakSelf = self;
            XMAlertView *alertV = [XMAlertView initWithTitle:@"您被大鱼吃了！" contentStr:nil cancelStr:@"结束" submitStr:@"重新开始"];
            [alertV showAction];
            [alertV setClickSubmitBlock:^{
                // 重新开始
                [weakSelf initAllView];
            }];
            [alertV setClickCancelBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [self playSoundAction:@"2.mp3"];
        }
    }
    return isMutul;
}

/// 判断两个view相交 -- 相交就不初始化
- (BOOL)isInitMutulAction:(UIView *)originV otherView:(UIView *)otherV {
//    BOOL isMutul = CGRectIntersectsRect(originV.frame, otherV.frame);
    // 判断圆心距离
    BOOL isMutul = NO;
    CGFloat centerDistance = [self getDistanceFromCenter:originV otherView:otherV];
    if (centerDistance < (originV.width + otherV.width)/2.0) {
        isMutul = YES;
    }
    return isMutul;
}

/// 计算两个view 中心点的距离
- (CGFloat)getDistanceFromCenter:(UIView *)originV otherView:(UIView *)otherV {
    CGPoint center1 = originV.center;
    CGPoint center2 = otherV.center;
    CGFloat distance = sqrt((center1.x - center2.x)*(center1.x - center2.x) + (center1.y - center2.y)*(center1.y - center2.y));
    return distance;
}

#pragma mark - 定时器
- (void)displayLinkMethod:(CADisplayLink *)displayLink {
    for (UIView *subV in self.view.subviews) {
        if (subV.tag >= 100) {
            subV.frame = CGRectMake(subV.left + 3, subV.top, subV.width, subV.height);
            if (subV.right > kScreenWidth_XM) {
                [subV removeFromSuperview];
                [self initOtherViewAction];
            }
            [self isMutulAction:self.meImageView otherView:subV];
        }
    }
}

#pragma mark - 播放音效
- (void)playSoundAction:(NSString *)urlStr {
    NSURL *moveMP3 = [NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:urlStr]];
    NSError *err = nil;
    self.movePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
    self.movePlayer.volume = 1.0;
    [self.movePlayer pause];
    [self.movePlayer prepareToPlay];
    [self.movePlayer play];
    [self.myTimer invalidate];
    self.myTimer = nil;
    if ([urlStr isEqualToString:@"2.mp3"]) {
        
    } else {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(stopSoundAction) userInfo:nil repeats:NO];
    }
}

- (void)stopSoundAction {
    self.myTimer = nil;
    [self.movePlayer stop];
}

#pragma mark - 懒加载
- (UIImageView *)meImageView {
    if (!_meImageView) {
        _meImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.meWidth, self.meHeight)];
        _meImageView.backgroundColor = [UIColor clearColor];
        [_meImageView setUserInteractionEnabled:YES];
        _meImageView.tag = 10;
        _meImageView.image = [UIImage imageNamed:@"me"];
        _meImageView.layer.masksToBounds = YES;
        _meImageView.layer.cornerRadius = self.meWidth/2.0;
    }
    return _meImageView;
}

@end
