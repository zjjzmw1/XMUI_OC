//
//  DemoCollectionVC2.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import "DemoCollectionVC2.h"
#import "DemoHorizontalCollectionViewCell.h"
#import "MLHorizontalCollectionViewFlowLayout.h"

@interface DemoCollectionVC2 ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSArray           *dataArr;

@end

@implementation DemoCollectionVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"测试CollectionView2"];
    [self initAllView];
}

- (void)initAllView {
    self.dataArr = @[@"标题大厦",@"asdg是大股东",@"违法额度股份的",@"水电费即可；了极大就是打开了； 甲方的抗衰老；安抚巾的",@"asdgjkldfg",@"标题大厦",@"asdg是大股东",@"违法额度股份的",@"水电费即可；了极大就是打开了； 甲方的抗衰老；安抚巾的",@"asdgjkldfg"];
    MLHorizontalCollectionViewFlowLayout *flowLayout = [[MLHorizontalCollectionViewFlowLayout alloc]init];
    flowLayout.horizonalType = MLHorizonalRight;
    flowLayout.minimumLineSpacing = 5; // 行之间的间隙 第0行和最后一行上面没有。
    flowLayout.minimumInteritemSpacing = 5; // 列间隙，第0列和最后一列没有
//    flowLayout.itemSize = CGSizeMake((kScreenWidth_XM - 20)/2 - 3, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 整个表格的内边距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, 200) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor yellowColor];
    [self.collectionView registerClass:NSClassFromString(@"DemoHorizontalCollectionViewCell") forCellWithReuseIdentifier:@"DemoHorizontalCollectionViewCell"];
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
    
    DemoHorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoHorizontalCollectionViewCell" forIndexPath:indexPath];
    NSString *str = self.dataArr[indexPath.item];
    [cell reloadAction:str];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [DemoHorizontalCollectionViewCell size:self.dataArr[indexPath.item]];
}

@end
