//
//  JDBMPurchaseViewController.m
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/23.
//

#import "JDBMPurchaseViewController.h"

@interface JDBMPurchaseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation JDBMPurchaseViewController

- (void)setOffsetY:(CGFloat)offsetY{
    self.tableView.contentOffset = CGPointMake(0, offsetY);
}

- (CGFloat)offsetY{
    return self.tableView.contentOffset.y;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    if (isCanScroll == YES){
        [self.tableView setContentOffset:CGPointMake(0, self.offsetY) animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"123"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.scrollView = _tableView;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    cell.textLabel.text = @"常规商品";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.scrollDelegate respondsToSelector:@selector(hoverChildViewController:scrollViewDidScroll:)]){
        [self.scrollDelegate hoverChildViewController:self scrollViewDidScroll:scrollView];
    }
}

@end

