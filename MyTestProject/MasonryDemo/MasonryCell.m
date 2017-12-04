//
//  MasonryCell.m
//  MyTestProject
//
//  Created by GT-iOS on 2017/12/4.
//  Copyright © 2017年 GT-iOS. All rights reserved.
//

#import "MasonryCell.h"
#import <Masonry.h>

@interface MasonryCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *bgLayer;
@end


@implementation MasonryCell
+ (instancetype)masonryCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"QLAppraiseCell";
    MasonryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MasonryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    [_titleLabel sizeToFit];
    [bgView addSubview:_titleLabel];
    
    // 只要约束加好, 就可以实现cell高度的自适应, 前提是影响cell高度的控件要加在contentView上
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    self.bgLayer = [CALayer layer];
    _bgLayer.backgroundColor = [UIColor purpleColor].CGColor;
    _bgLayer.frame = CGRectMake(5, 5, self.bounds.size.width - 10, 50);
    [self.contentView.layer insertSublayer:_bgLayer atIndex:0];
}

- (void)configCell {
    NSString *allText = @"抗战时期，毛泽东曾经多次阐述将来所要建立的“中华民主共和国”的含义。1948年12月30日，毛泽东为新华社写的1949年新年献词《将革命进行到底》明确宣布：“一九四九年将要召集没有反动分子参加的以完成人民革命任务为目标的政治协商会议，宣告中华人民共和国的成立，并组成共和国的中央政府。";
    
    int indxe = arc4random() % 142;
    NSString *subStr = [allText substringToIndex:indxe];
    self.titleLabel.text = subStr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgLayer.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.contentView.bounds.size.height - 10);
}





@end
