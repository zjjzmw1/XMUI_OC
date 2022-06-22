//
//  DemoDatePickerVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/22.
//

#import "DemoDatePickerVC.h"
#import "XMDatePickerView.h"
#import "UIView+XMTool.h"
#import "NSDate+XMTool.h"

@interface DemoDatePickerVC ()

@property (nonatomic, strong) UILabel           *testLbl;
@property (nonatomic, strong) XMDatePickerView  *datePickerView;
/// 选择的时间字符串
@property (nonatomic, strong) NSString          *selectDateString;

@end

@implementation DemoDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMDatePickerView"];
    
    [self.view addSubview:self.testLbl];
    self.testLbl.frame = CGRectMake(0, 100, kScreenWidth_XM, 50);
    self.testLbl.text = @"请选择日期";
}

- (UILabel *)testLbl {
    if (!_testLbl) {
        _testLbl = [[UILabel alloc] init];
        _testLbl.textAlignment = NSTextAlignmentCenter;
        _testLbl.font = [UIFont systemFontOfSize:19];
        _testLbl.textColor = [UIColor blackColor];
        [_testLbl setUserInteractionEnabled:YES];
        __weak typeof(self) weakSelf = self;
        [_testLbl setTapActionWithBlock:^{
            [weakSelf chooseDateAction];
        }];
    }
    return _testLbl;
}

#pragma mark - 选择日期
-(void)chooseDateAction {
    NSDate *date = [NSDate date];
    if (self.selectDateString.length > 0) {
        date =  [NSDate getDateWithFormateString:@"yyyy-MM" dateString:self.selectDateString];
    }
    __weak typeof(self) weakSelf = self;
    if (self.datePickerView == nil) {
        self.datePickerView = [[XMDatePickerView alloc] initDateWithTypeWithDefaultDate:date doneBlock:^(NSString *selectedDate) {
            NSLog(@"dd=====%@",selectedDate);
            if (![selectedDate isEqualToString:@"全部"]) {
                self.selectDateString = selectedDate;
            }
            weakSelf.testLbl.text = selectedDate;
        }];
    }
    [self.datePickerView showAction];
}

@end
