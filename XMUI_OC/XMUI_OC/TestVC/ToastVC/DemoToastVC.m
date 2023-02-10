//
//  ToastVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "DemoToastVC.h"
#import "XMCustomNaviView.h"
#import "UITableView+XMTool.h"
#import "XMSizeMacro.h"

#import "XMToast.h"
#import "Person.h"

@interface DemoToastVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation DemoToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.customNaviView setTitleStr:@"XMToast"];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"S 短文案",@"S 合理的中等长度",@" S 不合理的长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案",@"短文案",@"合理的中等长度",@"不合理的长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案"
        ,@"测试"]];
    self.tableView = [UITableView instanceWithType:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM);
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (self.dataArr.count > indexPath.row) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == self.dataArr.count - 1) { // 测试用的
        // 测试局部变量的block，会不会循环引用
        __weak typeof(self) wSelf = self;
        Person *p = [[Person alloc] init];
        p.testBlock = ^{
            self.title = @"1223"; // 如果self的时候，p对象没添加到self子view上或者没被引用的地方，self就OK
            NSLog(@"234535");
        };
        p.testBlock();
        
       // 测试： __weak __strong
    //    __weak typeof(self) wSelf = self;
    //    //  @weakify(self);
    //    self.testBlock = ^{
    //    //  @strongify(self);
    //        __strong typeof(wSelf) wStrongSelf = wSelf;
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"11111---%@",wStrongSelf); // 这里的wStrongSelf相当于引用计数+1了，等这个延时方法执行后-1，也类似于逃逸闭包，延时执行的时候，保证self不被释放
    //        });
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"2222---%@",wSelf); // 没用wStrongSelf的话，就可能会释放，比如pop到上个页面的时候，self就销毁了（由于没用wStrongSelf，所以类似于非逃逸闭包，不保证延时执行的时候self还在。如果页面提前pop出去了，就会导致self为空）
    //        });
    //        [wStrongSelf.navigationController popViewControllerAnimated:YES];
        
    //    };
    //    self.testBlock();

        
        return;
    }
    
    
    
    if (self.dataArr.count > indexPath.row) {
        NSString *str = self.dataArr[indexPath.row];
        if (indexPath.row < 3) {
            [XMToast showText:str positionType:XMToastPositionTypeCenter];
        } else {
            [XMToast showText:str positionType:XMToastPositionTypeBottom];
        }
    }
}

@end
