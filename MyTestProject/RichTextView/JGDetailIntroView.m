//
//  JGDetailIntroView.m
//  TeacherA
//
//  Created by MQL-IT on 2017/9/5.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

#import "JGDetailIntroView.h"
#import "MyTestProject-Swift.h"
#define SDScreenWidth [UIScreen mainScreen].bounds.size.width
#define SDScreenHeight [UIScreen mainScreen].bounds.size.height
@interface JGDetailIntroView ()<RichEditorDelegate>
@property (nonatomic, strong) RichEditorView *editorView;
@end

@implementation JGDetailIntroView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.editorView];
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
    _editorView.html = contentStr;//@"<b>Q<font size=\"6\">q</font><font size=\"3\">q<font color=\"#00ff00\">bbbg</font></font></b>";//@"Rrrrffggfffffffffffffffggggg<div>Yyyyyyyyyyyyyyyyyyyy</div><br><div style=\"text-align: center;\"><img src=\"http://img.shjujiao.com/test/25ae56ed-650e-4b6e-9e79-40f4245c8a97.jpg\" alt=\"图片加载中\" style=\"font-size: 13.5pt; -webkit-text-size-adjust: 100%;\"></div>yyttgggghhhdxxffffggg<br><div style=\"text-align: center;\"><img src=\"http://img.shjujiao.com/test/3db3687b-3864-4b9d-a03a-75fd5fdde943.jpg\" alt=\"图片加载中\" style=\"font-size: 13.5pt; -webkit-text-size-adjust: 100%;\"></div><br>";  //contentStr;
}

- (RichEditorView *)editorView {
    if (!_editorView) {
        _editorView = [[RichEditorView alloc]initWithFrame:self.bounds];
        _editorView.delegate = self;
        _editorView.isScrollEnabled = NO;
        _editorView.isEditingEnabled = NO;
    }
    return _editorView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _editorView.frame = self.bounds;
}

- (void)richEditor:(RichEditorView *)editor heightDidChange:(NSInteger)height {
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
    [self layoutSubviews];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(introViewDidChangeContenHeight)]) {
        [self.delegate introViewDidChangeContenHeight];
    }
}

@end
