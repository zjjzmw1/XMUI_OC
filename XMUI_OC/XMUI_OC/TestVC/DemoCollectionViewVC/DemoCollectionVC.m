//
//  DemoCollectionVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import "DemoCollectionVC.h"
#import "DemoCollectionCell.h"

#import "DemoCollectionVC2.h"

@interface DemoCollectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSArray           *dataArr;

@end

@implementation DemoCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"测试CollectionView"];
    [self.customNaviView setRightBtnImage:nil title:@"demo2"];
    __weak typeof(self) weakSelf = self;
    [self.customNaviView setRightBlock:^{
        DemoCollectionVC2 *vc = [DemoCollectionVC2 new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self initAllView];
}

- (void)initAllView {
    self.dataArr = @[@"标题大厦",@"asdg是大股东",@"违法额度股份的",@"水电费即可；了极大就是打开了； 甲方的抗衰老；安抚巾的",@"asdgjkldfg",@"标题大厦",@"asdg是大股东",@"违法额度股份的",@"水电费即可；了极大就是打开了； 甲方的抗衰老；安抚巾的",@"asdgjkldfg"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5; // 行之间的间隙 第0行和最后一行上面没有。
    flowLayout.minimumInteritemSpacing = 5; // 列间隙，第0列和最后一列没有
    flowLayout.itemSize = CGSizeMake((kScreenWidth_XM - 20)/2 - 3, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 整个表格的内边距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, 200) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor yellowColor];
    [self.collectionView registerClass:NSClassFromString(@"DemoCollectionCell") forCellWithReuseIdentifier:@"DemoCollectionCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
    
    CGSize totalSize = flowLayout.collectionViewContentSize;
    NSLog(@"内容高度为：%f",totalSize);

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoCollectionCell" forIndexPath:indexPath];
    NSString *str = self.dataArr[indexPath.item];
    [cell reloadAction:str];
    return cell;
}

@end
