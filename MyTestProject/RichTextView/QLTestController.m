//
//  QLTestController.m
//  TeacherA
//
//  Created by MQL-IT on 2017/8/21.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

#import "QLTestController.h"
#import "ETL_RichView.h"
#define SDScreenWidth [UIScreen mainScreen].bounds.size.width
#define SDScreenHeight [UIScreen mainScreen].bounds.size.height
@interface QLTestController ()<ETL_RichViewDelegate>
@property (nonatomic, strong) ETL_RichView *detailIntroView;
@end

@implementation QLTestController

- (void)dealloc {
    NSLog(@"释放控制器");
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.detailIntroView];
    self.detailIntroView.contentStr = @"<p><img src=\"http://7xsa5j.com2.z0.glb.qiniucdn.com/2/2017-12-11-18&#58;07&#58;32--mashaladi1\" alt=\"\"><br>张大千（Chang Dai-Chien），男，四川内江人，祖籍广东省番禺，1899年5月10日出生于四川省内江市中区城郊安良里的一个书香门第的家庭，中国泼墨画家，书法家。<br>20 世纪50年代，张大千游历世界，获得巨大的国际声誉，被西方艺坛赞为“东方之笔”。[1]<br>他与二哥张善子昆仲创立“大风堂派”，是二十世纪中国画坛最具传奇色彩的泼墨画工。特别在山水画方面卓有成就。后旅居海外，画风工写结合，重彩、水墨融为一体，尤其是泼墨与泼彩，开创了新的艺术风格，因其诗、书、画与齐白石、溥心畲齐名，故又并称为“南张北齐”和“南张北溥”，名号多如牛毛。与黄君璧、溥心畲以“渡海三家”齐名。二十多岁便蓄著一把大胡子，成为张大千日后的特有标志。";
}

// 图文混排详情
- (ETL_RichView *)detailIntroView {
    if (!_detailIntroView) {
        _detailIntroView = [[ETL_RichView alloc]initWithFrame:CGRectMake(0, 0, SDScreenWidth, 50)];
        _detailIntroView.delegate = self;
        _detailIntroView.lineLayer.hidden = YES;
    }
    return _detailIntroView;
}
- (void)introViewDidChangeContenHeight {
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
