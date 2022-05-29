//
//  XMTextView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "XMTextView.h"

@interface XMTextView() {
    BOOL _shouldDrawPlaceholder;
}

- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;

@end

@implementation XMTextView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _placeholerFont = [UIFont systemFontOfSize:15];
        [self _initialize];
    }
    return self;
}

- (void)setText:(NSString *)string {
    [super setText:string];
    [self _updateShouldDrawPlaceholder];
}

- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    _placeholder = string;
    [self _updateShouldDrawPlaceholder];
    [self setNeedsDisplay];
}

//9.1系统的个别机型没有下面这个方法的话，会出现汉字被上下拉高了。
- (void)layoutSubviews {
    [self setNeedsDisplay];
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder) {
        if (self.placeholderColor) {
            if (!self.placeholerFont) {
                self.placeholerFont = [UIFont systemFontOfSize:15]; // 默认font
            }
                        
            // 修复 placeholder和光标不对齐的bug
            CGSize size = CGSizeMake(rect.size.width - 8, rect.size.height - 16);
            [_placeholder drawInRect:CGRectMake(4.0f, 8.0f, size.width - 8, size.height) withAttributes:@{ NSFontAttributeName: self.placeholerFont, NSForegroundColorAttributeName: self.placeholderColor }];
        }
    }
}

#pragma mark - Private

- (void)_initialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    ///默认的文字的颜色。。。也可以自己设定。
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
}

- (void)_updateShouldDrawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}

- (void)_textChanged:(NSNotification *)notificaiton {
    [self _updateShouldDrawPlaceholder];
}



@end

