//
//  MaskLayerController.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/1/10.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "MaskLayerController.h"
#import "GradientLabel.h"

@interface MaskLayerController ()
@property (nonatomic, strong) GradientLabel *label;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation MaskLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.gradientLayer];
    self.myLabel = [UILabel new];
    _myLabel.textAlignment = NSTextAlignmentRight;
    _myLabel.text = @"测试一下";
    //把label的layer设置为gradientLayer的mask之后, label的frame是以gradientLayer为坐标的
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 64, 200, 50);
    [but setTitle:@"我是一个按钮" forState:UIControlStateNormal];
    [self.view addSubview:but];
    [but.layer insertSublayer:self.gradientLayer atIndex:0];
    self.gradientLayer.mask = but.titleLabel.layer;
    
    
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0.0,1.0);
        _gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        _gradientLayer.frame = CGRectMake(0, 0, 200, 50);
        _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    }
    return _gradientLayer;
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
