//
//  ETL_CheckProtocolView.m
//  etiaolong
//
//  Created by GT-iOS on 2018/1/18.
//  Copyright © 2018年 etiaolong. All rights reserved.
//

#import "ETL_CheckProtocolView.h"
#import <Masonry.h>
#import <YYKit.h>
@interface ETL_CheckProtocolView()<UITextViewDelegate>
{
    CGFloat _h;
}
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) YYLabel *myTextView;
@end

@implementation ETL_CheckProtocolView

@synthesize isChecked = _isChecked;

- (instancetype)initWithFrame:(CGRect)frame string:(NSString *)string checkStrings:(NSArray *)stringValues {
    if (self = [super initWithFrame:frame]) {
         _h = [self getSpaceLabelHeightWithString:string speace:8 withFont:[UIFont systemFontOfSize:12] withWidth:self.bounds.size.width - 30 - 20];
        [self setupSubViews];
        [self configStrings:string strings:stringValues];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect temp = self.frame;
    if (temp.size.height < 1) {
        temp.size.height = _h + 30;
        self.frame = temp;
    }
}

- (void)configStrings:(NSString *)str strings:(NSArray *)strings {
    NSMutableAttributedString *attributedString = [[self stringWithString:str ParagraphlineSpeace:8 textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:12]]mutableCopy];
    
    for (NSString *protoStr in strings) {
        NSMutableAttributedString *att = [[self stringWithString:protoStr ParagraphlineSpeace:5 textColor:[UIColor orangeColor] textFont:[UIFont systemFontOfSize:12]]mutableCopy];
//        YYTextBorder *border = [YYTextBorder new];
//        border.fillColor = [UIColor redColor];
        YYTextHighlight *highlight = [YYTextHighlight new];
//        [highlight setBackgroundBorder:border];
        highlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [self.delegate didClickProtocolString:[[attributedString string] substringWithRange:range]];
            NSLog(@"%@ --- %@", [text string], [[attributedString string] substringWithRange:range]);
        };
        [att setTextHighlight:highlight range:att.rangeOfAll];
        [attributedString replaceCharactersInRange:[[attributedString string] rangeOfString:protoStr] withAttributedString:att];
    }
    self.myTextView.attributedText = attributedString;
}

- (void)setupSubViews {
    self.selectBtn = ({
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
        but.selected = YES;
        [but addTarget:self action:@selector(clickBitton:) forControlEvents:UIControlEventTouchUpInside];
        but;
    });
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.width.mas_equalTo(47);
    }];
    
    self.myTextView = ({
        YYLabel *label = [YYLabel new];
        label.numberOfLines = 0;
        label.backgroundColor = self.backgroundColor;
        label;
    });
    [self insertSubview:self.myTextView belowSubview:self.selectBtn];
    [self.myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.imageView.mas_right).offset(5);
        make.top.equalTo(self.selectBtn.imageView.mas_top).offset(0.5);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(_h + 5);
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickProtocolString:)]) {
        [self.delegate didClickProtocolString:[URL absoluteString]];
        
    }
    return NO;
}

- (void)clickBitton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

#pragma mark - getters
- (BOOL)isChecked {
    return self.selectBtn.isSelected;
}

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    self.selectBtn.selected = isChecked;
}

#pragma mark - 富文本
-(NSAttributedString *)stringWithString:(NSString *)str
                    ParagraphlineSpeace:(CGFloat)lineSpacing
                              textColor:(UIColor *)textcolor
                               textFont:(UIFont *)font {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//     NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, str.length)];
    return attriStr;
}

-(CGFloat)getSpaceLabelHeightWithString:(NSString *)str
                                 speace:(CGFloat)lineSpeace
                               withFont:(UIFont*)font
                              withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


@end
