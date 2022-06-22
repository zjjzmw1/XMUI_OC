//
//  XMDatePickerView.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/22.
//

#import "XMDatePickerView.h"

#import "NSDate+XMTool.h"

@interface XMDatePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

/// 顶部条
@property (nonatomic, strong) UIView            *topBarView;
@property (nonatomic, strong) UIButton          *doneBtn;
@property (nonatomic, strong) UIButton          *cancelBtn;
/// 标题
@property (nonatomic, strong) UILabel           *titleLbl;
/// 蒙层
@property (nonatomic, strong) UIView            *maskView;
@property (nonatomic, strong) UIView            *containerView;
@property (nonatomic, strong) UIPickerView      *datePicker;
@property (nonatomic, strong) UIView            *dateView;
@property (nonatomic, strong) NSDate            *selectedDate;

@property (nonatomic, copy) XMDateSubmitBlock   submitBlock;

/// 当前选中的年份
@property (nonatomic, assign) NSString          *yearValue;
@property (nonatomic, strong) NSMutableArray    *yearArray;
/// 当前选中的月份
@property (nonatomic, copy) NSString            *monthValue;
@property (nonatomic, strong) NSMutableArray    *monthArray;
/// 共有几列
@property(nonatomic, assign) NSInteger          conponentsCount;
/// 最终用户选择的字符串
@property (nonatomic, strong) NSString          *lastSelectStr;
/// 当前选中的第一列row
@property (nonatomic, assign) NSInteger         currentFirstSelectRow;
/// 当前选中的第二列row
@property (nonatomic, assign) NSInteger         currentSecondSelectRow;

@end

@implementation XMDatePickerView

- (instancetype)initDateWithTypeWithDefaultDate:(NSDate *)defaultDate
                                      doneBlock:(XMDateSubmitBlock)submitBlock {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _submitBlock = submitBlock;
        _conponentsCount = 2; // 两列
        self.selectedDate = defaultDate;
        [self initAllView];
    }
    return self;

}

- (void)initAllView {
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 216 + 50)];
    self.containerView.backgroundColor =  [UIColor whiteColor];
    [self addRectCorner:4 corners:UIRectCornerTopLeft|UIRectCornerTopRight toView:self.containerView];
    [self addSubview:self.maskView];
    [self addSubview:self.containerView];
    
    [self createContentView];
    
    _topBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [self.containerView addSubview:self.topBarView];
    [_topBarView addSubview:self.doneBtn];
    [_topBarView addSubview:self.cancelBtn];
    [_topBarView addSubview:self.titleLbl];
    _topBarView.backgroundColor = [UIColor whiteColor];
        
    self.doneBtn.frame = CGRectMake(self.frame.size.width - 44 - 15, 0, 44, 50);
    self.cancelBtn.frame = CGRectMake(15, 0, 44, 50);
    self.titleLbl.frame = CGRectMake(50, 0, self.frame.size.width - 100, 50);
}

- (void)createContentView {
    NSMutableArray* tempArray1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray* tempArray2 = [[NSMutableArray alloc] initWithCapacity:0];
    [self setYearArray:tempArray1];
    [self setMonthArray:tempArray2];
    // 数据源
    [self createDataSource];
    // 时间日期View
    UIView * datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0,50, self.frame.size.width, 216)];
    // 初始化各个视图
    self.datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0,  datePickerView.frame.size.width, datePickerView.frame.size.height)];
    [datePickerView addSubview:self.datePicker];
    [self.containerView addSubview:datePickerView];
    [self.datePicker setDataSource:self];
    [self.datePicker setDelegate:self];
    [self resetDateToCurrentDate:_selectedDate];
}

#pragma mark -创建数据源  年月日闰年＝情况分析
-(void)createDataSource {
    // 年
    [self.yearArray removeAllObjects];
    [self.yearArray addObject:@"全部"];
    NSInteger startYear = [NSDate date].getYearInteger - 3;
    NSInteger endYear   =  [NSDate date].getYearInteger + 3;
    for (NSInteger i=startYear; i<= endYear; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%04lu",i]];
    }
    // 月
    [self createMonthDataSource];
}

-(void)createMonthDataSource {
    [self.monthArray removeAllObjects];
    NSInteger fromMonth = 1;
    NSInteger endMonth = 12;
    for (NSInteger i=fromMonth; i<=endMonth; i++) {
        [self.monthArray addObject:[NSString stringWithFormat:@"%02lu",i]];
    }
}

- (void)resetDateToCurrentDate:(NSDate *)nowDate {
    NSInteger year  = [nowDate getYearInteger];
    NSInteger yearIndex = 0;
    for(NSInteger index= 0; index<self.yearArray.count; index++){
        NSString *yearStr = [self.yearArray objectAtIndex:index];
        if([yearStr integerValue] == year){
            yearIndex = index;
            break;
        }
    }
    [self.datePicker selectRow:yearIndex inComponent:0 animated:YES];
    NSInteger month  = [nowDate getMonthInteger];
    NSInteger monthIndex = 0;
    for(NSInteger index= 0; index<self.monthArray.count; index++){
        NSString *monthStr = [self.monthArray objectAtIndex:index];
        if([monthStr integerValue] == month){
            monthIndex = index;
            break;
        }
    }
    [self.datePicker selectRow:monthIndex inComponent:1 animated:YES];
    [self setYearValue:[NSString stringWithFormat:@"%04ld",[nowDate getYearInteger]]];
    [self setMonthValue:[NSString stringWithFormat:@"%02ld",[nowDate getMonthInteger]]];
}

#pragma mark - 弹出展示
/// 弹出展示
- (void)showAction {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.25
                     animations:^{
        self.containerView.frame = CGRectMake(0, kScreenHeight_XM - (216 + 50), kScreenWidth_XM ,  216 + 50);
        self.maskView.alpha = 0.6;
    }];
    
    /// 刷新设置当前选中的行
    for (int i = 0; i < self.yearArray.count; i++) {
        if ([self.yearValue isEqualToString:self.yearArray[i]]) {
            self.currentFirstSelectRow = i;
        }
    }
    for (int i = 0; i < self.monthArray.count; i++) {
        if ([self.monthValue isEqualToString:self.monthArray[i]]) {
            self.currentSecondSelectRow = i;
        }
    }
    // 首次进入刷新
    [self.datePicker reloadAllComponents];
}

#pragma mark - 隐藏
- (void)hideAction {
    [UIView animateWithDuration:0.22
                     animations:^{
        self.containerView.frame = CGRectMake(0, self.frame.size.height, self.containerView.frame.size.width, self.containerView.frame.size.height);
        self.maskView.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 确定按钮点击
- (void)doneAction {
    [self hideAction];
    self.lastSelectStr = [NSString stringWithFormat:@"%@-%@",self.yearValue, self.monthValue];
    if ([self.yearValue isEqualToString:@"全部"]) {
        self.lastSelectStr = @"全部";
    }
    if( self.submitBlock) {
        self.submitBlock(self.lastSelectStr);
    }
}

#pragma mark - 取消按钮点击
- (void)cancelAction {
    [self hideAction];
}

#pragma mark - UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.conponentsCount;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return  self.yearArray.count;
    } else if (component == 1) {
        if ([self.yearValue isEqualToString:@"全部"]) {
            return 0;
        } else {
            return self.monthArray.count;
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *textlbl = [[UILabel alloc] init];
    textlbl.textAlignment = NSTextAlignmentCenter;
    textlbl.font = [UIFont systemFontOfSize:18];
    textlbl.textColor = [UIColor grayColor];
    if (component == 0) {
        if (self.currentFirstSelectRow == row) {
            textlbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
            textlbl.textColor = [UIColor blackColor];
        }
    }
    if (component == 1) {
        if (self.currentSecondSelectRow == row) {
            textlbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
            textlbl.textColor = [UIColor blackColor];
        }
    }
    if (component == 0) {
        textlbl.text = [self.yearArray objectAtIndex:row];
    } else if (component == 1) {
        textlbl.text = [self.monthArray objectAtIndex:row];
    }
    return textlbl;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.yearValue = [self.yearArray objectAtIndex:row];
        self.currentFirstSelectRow = row;
    } else if(component == 1) {
        self.monthValue = [self.monthArray objectAtIndex:row];
        self.currentSecondSelectRow = row;
    }
    self.lastSelectStr = [NSString stringWithFormat:@"%@-%@",self.yearValue, self.monthValue];
    // 刷新整个展示
    [pickerView reloadAllComponents];
}

#pragma mark - 懒加载
- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] init];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:18];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"日期选择";
    }
    return _titleLbl;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.0;
    }
    return _maskView;
}

#pragma mark - 为了不依赖其他类，把切圆角的方法，写到这里
/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 *  @param toView  给哪个view设置圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners toView:(UIView *)toView {
    // 设置圆角，需要view有frame
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:toView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = toView.bounds;
    maskLayer.path = maskPath.CGPath;
    toView.layer.mask = maskLayer;
}


@end
