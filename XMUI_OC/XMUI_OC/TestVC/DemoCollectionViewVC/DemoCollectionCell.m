//
//  DemoCollectionCell.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import "DemoCollectionCell.h"

@interface DemoCollectionCell()

@property (nonatomic, strong) UIImageView   *iconImgV;
@property (nonatomic, strong) UILabel       *titleLbl;

@end

@implementation DemoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.iconImgV];
    [self.contentView addSubview:self.titleLbl];
    
    self.iconImgV.frame = CGRectMake(16, 10, 20, 20);
    self.titleLbl.frame = CGRectMake(self.iconImgV.right + 10, 10, 10, 20);
    
    return self;
}

/// 刷新数据
- (void)reloadAction:(NSString *)titleStr {
    self.iconImgV.backgroundColor = [UIColor redColor];
    self.titleLbl.text = titleStr;
    [self.titleLbl sizeToFit];
    CGFloat width = self.titleLbl.width;
    if (width > self.frame.size.width - (self.iconImgV.right + 10)) {
        width = self.frame.size.width - (self.iconImgV.right + 10);
        self.titleLbl.frame = CGRectMake(self.iconImgV.right + 10, 10, width, 20);
    }
}

#pragma mark - 懒加载

- (UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc] init];
    }
    return _iconImgV;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.numberOfLines = 1;
    }
    return _titleLbl;
}

@end
