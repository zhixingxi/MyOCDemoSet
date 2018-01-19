//
//  TextViewDemoController.m
//  MyTestProject
//
//  Created by MQL-IT on 2018/1/18.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "TextViewDemoController.h"

@interface TextViewDemoController ()

@end

@implementation TextViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    CGFloat h = [self getSpaceLabelHeightwithSring:@"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" Speace:2 withFont:[UIFont systemFontOfSize:12] withWidth:self.view.bounds.size.width - 30];
    NSLog(@"%f", h);
    NSAttributedString *att = [self stringWithParagraphlineSpeace:2 textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:12] str:@"中华人民共和国中华人民共中华人民共和国中华人民共和国和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国"];
    UITextView *v = [[UITextView alloc]initWithFrame:CGRectMake(15, 200, self.view.bounds.size.width - 30, h)];
    [self.view addSubview:v];
    v.scrollEnabled = NO;
    v.attributedText = att;
    v.textContainer.lineFragmentPadding = 0;
    v.textContainerInset = UIEdgeInsetsZero;
    
}
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font
                                                 str:(NSString *)str {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paragraphStyle.lineHeightMultiple = 1.5;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, str.length)];
    return attriStr;
}



-(CGFloat)getSpaceLabelHeightwithSring:(NSString *)str Speace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
