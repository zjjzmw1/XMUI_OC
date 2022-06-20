//
//  OrderListCell.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/20.
//

#import "OrderListCell.h"

@interface OrderListCell()

/// 标题
@property (nonatomic, strong) UILabel       *titleLbl;
/// 选中按钮
@property (nonatomic, strong) UIImageView   *selectImageV;

@end

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.selectImageV];
        self.titleLbl.frame = CGRectMake(18, 12, [UIScreen mainScreen].bounds.size.width - 100, 20);
        self.selectImageV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 18 - 18, 13, 18, 18);
    }
    return self;
}

/// 刷新数据
- (void)reloadData:(NSInteger)currentRow selectRow:(NSInteger)selectRow title:(NSString *)titleString {
    self.titleLbl.text = titleString;
    self.selectImageV.image = [UIImage imageNamed:@"close_icon"];
    if (currentRow == selectRow) {
        self.selectImageV.image = [UIImage imageNamed:@"error_icon"];
    }
}

#pragma mark - 懒加载

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLbl;
}

- (UIImageView *)selectImageV {
    if (!_selectImageV) {
        _selectImageV = [[UIImageView alloc] init];
    }
    return _selectImageV;
}

@end
