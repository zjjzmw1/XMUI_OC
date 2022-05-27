//
//  JDBMChangePageView.m
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/23.
//

#import "JDBMChangePageView.h"
#import "XMSizeMacro.h"
//#import <JDTMasonry/Masonry.h>
//#import <WJOACommonModule/GlobalMacro.h>
//#import <JDBFoundationModule/JDBFoundationModule-umbrella.h>
//#import <JDTYYCategoriesModule/YYCategories.h>

@interface JDBMChangePageView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)NSArray *arrData;
@property (assign, nonatomic)NSInteger selectIndex;
@end

@implementation JDBMChangePageView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data {
    if (self = [super initWithFrame:frame]) {
        [self initDataWithData:data];
        [self initUI];
        [self initFrame];
    }
    return self;
}

#pragma mark init data ui

- (void)initDataWithData:(NSArray *)data {
    self.arrData  = data.copy;
    self.selectIndex = 0;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
}

- (void)initFrame {
    self.collectionView.frame = CGRectMake(50, 0, kScreenWidth_XM - 100, kScreenHeight_XM - kNaviStatusBarH_XM - kSafeAreaBottom_XM - 50);
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self);
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//    }];
}

- (void)showViewWithData:(NSArray *)data {
    self.arrData = data.copy;
    [self.collectionView reloadData];
}

- (void)changeViewWithTag:(NSInteger)tag {
    
    NSInteger index = -1;
    for (NSInteger arrIndex = 0; arrIndex < self.arrData.count; arrIndex ++) {
        NSDictionary *dict  =  self.arrData[arrIndex];
        if (tag == [dict[@"tag"] integerValue]) {
            index =  arrIndex;
            break;
        }
    }
    
    if (index >= 0 && index < self.arrData.count) {
        self.selectIndex = index;
        [self.collectionView reloadData];
    }
}

#pragma mark collection lazy loading

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell self] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}


#pragma mark  collection delegate and datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float cellWidth = (kScreenWidth_XM -100) /self.arrData.count;
    
    NSDictionary * cellDict  = self.arrData[indexPath.row];
    NSString * strTitle = cellDict[@"title"];
    
//    if (!JDUtils.validateString(strTitle)) {
//        strTitle = @"";
//    }
    CGSize size = [strTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat finalWidth =  size.width + 10 > cellWidth ? size.width + 10 : cellWidth;
    
    return CGSizeMake(finalWidth, 44 );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dict = self.arrData[indexPath.row];
    BOOL isSelected = (self.selectIndex == indexPath.row ? YES : NO);
//    [cell showContentWithModel:dict isSelected:isSelected];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict  = self.arrData[indexPath.row];
    
    self.selectIndex = indexPath.row;
    [self.collectionView reloadData];

    if (self.dictCallBack) {
        self.dictCallBack(dict);
    } else if (self.tagCallBack) {
        self.tagCallBack([dict[@"tag"] integerValue]);
    }
  //  NSString *eventID = [NSString stringWithFormat:@"w_1574246530196|%@",dict[@"tag"]];
 //   [self clickMTAWithEventsID:eventID eventParam:eventID currentPage:@"wanjia_buycart" currentPageID:@"wanjia_buycart" customParam:nil];
}
@end
