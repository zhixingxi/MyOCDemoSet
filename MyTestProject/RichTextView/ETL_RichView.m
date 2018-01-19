//
//  ETL_RichView.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/1/19.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "ETL_RichView.h"
#import "MyTestProject-Swift.h"
#define SDScreenWidth [UIScreen mainScreen].bounds.size.width
#define SDScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ETL_RichView()<ETL_RichTextViewDelegate>
@property (nonatomic, strong) ETL_RichTextView *ediView;

@end
@implementation ETL_RichView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.ediView];
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor redColor].CGColor;
        line.frame = CGRectMake(15, 0, SDScreenWidth - 30, 0.5);
        self.lineLayer = line;
        [self.layer addSublayer:line];
    }
    return self;
}

- (void)setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    _ediView.html = contentStr;//@"<b>Q<font size=\"6\">q</font><font size=\"3\">q<font color=\"#00ff00\">bbbg</font></font></b>";//@"Rrrrffggfffffffffffffffggggg<div>Yyyyyyyyyyyyyyyyyyyy</div><br><div style=\"text-align: center;\"><img src=\"http://img.shjujiao.com/test/25ae56ed-650e-4b6e-9e79-40f4245c8a97.jpg\" alt=\"图片加载中\" style=\"font-size: 13.5pt; -webkit-text-size-adjust: 100%;\"></div>yyttgggghhhdxxffffggg<br><div style=\"text-align: center;\"><img src=\"http://img.shjujiao.com/test/3db3687b-3864-4b9d-a03a-75fd5fdde943.jpg\" alt=\"图片加载中\" style=\"font-size: 13.5pt; -webkit-text-size-adjust: 100%;\"></div><br>";  //contentStr;
}

- (ETL_RichTextView *)ediView {
    if (!_ediView) {
        _ediView = [[ETL_RichTextView alloc]initWithFrame:self.bounds];
        _ediView.delegate = self;
    }
    return _ediView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _ediView.frame = self.bounds;
}

- (void)richEditor:(ETL_RichTextView *)editor heightDidChange:(NSInteger)height {
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
    [self layoutSubviews];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(introViewDidChangeContenHeight)]) {
        [self.delegate introViewDidChangeContenHeight];
    }
}

@end
