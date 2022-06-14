//
//  DemoHorizontalCollectionViewCell.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import "DemoHorizontalCollectionViewCell.h"

@interface DemoHorizontalCollectionViewCell()

@property (nonatomic, strong) UILabel       *titleLbl;

@end

@implementation DemoHorizontalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.titleLbl];
    [self resize];
    
    return self;
}

/// 刷新数据
- (void)reloadAction:(NSString *)titleStr {
    self.titleLbl.text = titleStr;
    [self.titleLbl sizeToFit];
    [self resize];
}

- (void)resize {
    CGRect frame = self.titleLbl.frame;
    frame.origin.x = 0.0;
    if (self.titleLbl.frame.size.width > self.frame.size.width) {
        frame.size.width = self.frame.size.width;
    }
    self.titleLbl.frame = frame;
    CGPoint center = self.titleLbl.center;
    center.y = self.frame.size.height/2;
    self.titleLbl.center = center;
}


+ (CGSize)size:(NSString *)text {
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12.0]
                                 } context:nil];
    return CGSizeMake(textRect.size.width + 10.0, 20.0);
}

#pragma mark - 懒加载

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:12.0];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.backgroundColor = [UIColor blueColor];
        _titleLbl.numberOfLines = 1;
    }
    return _titleLbl;
}

@end
