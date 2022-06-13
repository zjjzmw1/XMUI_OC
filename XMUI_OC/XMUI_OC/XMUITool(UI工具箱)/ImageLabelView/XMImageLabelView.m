//
//  XMImageLabelView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/7.
//

#import "XMImageLabelView.h"

@interface XMImageLabelView()

@end

@implementation XMImageLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.iconImgV];
    [self addSubview:self.titleLbl];
        
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicAction)];
    [self addGestureRecognizer:tap];
    
    return self;
}

/// 刷新数据
/// @param image 图标
/// @param text 文字
- (void)reloadDataWithImage:(UIImage *)image textString:(NSString *)text type:(XMImageLabelType)type {
    self.iconImgV.image = image;
    self.titleLbl.text = text;
    [self.titleLbl sizeToFit];
    CGFloat textWidth = self.titleLbl.frame.size.width;
    CGFloat textHeight = self.titleLbl.frame.size.height;
    CGFloat lastW = self.frame.size.width;
    CGFloat lastH = self.frame.size.height;
    if (textWidth > self.frame.size.width) {
        lastW = textWidth;
        // 更新self.frame
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lastW, lastH);
    }
    if (image.size.width > self.frame.size.width) {
        lastW = image.size.width;
    }
    if (textHeight + image.size.height > self.frame.size.height) {
        lastH = textHeight + image.size.height;
    }
    
    // 更新最终frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lastW, lastH);
    CGFloat imageLabelSpace = (lastH - textHeight - image.size.height)/3.0; // 「最上面、最下面、中间」 间隙一样。
    if (type == XMImageLabelType_ImageTop) { // 图片上、文字下
        self.iconImgV.frame = CGRectMake((self.frame.size.width - image.size.width)/2.0, imageLabelSpace, image.size.width, image.size.height);
        self.titleLbl.frame = CGRectMake(0, self.iconImgV.bottom + imageLabelSpace, self.frame.size.width, textHeight);
    } else { // 文字上 图片下
        self.titleLbl.frame = CGRectMake(0, imageLabelSpace, self.frame.size.width, textHeight);
        self.iconImgV.frame = CGRectMake((self.frame.size.width - image.size.width)/2.0, self.titleLbl.bottom + imageLabelSpace, image.size.width, image.size.height);
    }
}

#pragma mark - 点击回调
- (void)clicAction {
    if (self.clickBlock) {
        self.clickBlock();
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
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:15];
    }
    return _titleLbl;
}

@end
