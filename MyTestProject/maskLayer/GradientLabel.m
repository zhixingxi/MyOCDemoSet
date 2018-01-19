//
//  GradientLabel.m
//  iphoneLive
//
//  Created by 郭常青 on 2016/12/2.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "GradientLabel.h"

@interface GradientLabel ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation GradientLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setGradientLabel];
    }
    return self;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0.0,1.0);
        _gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        _gradientLayer.frame = self.label.frame;
        _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    }
    return _gradientLayer;
}


- (void) setGradientLabel {
    
    self.label = [[UILabel alloc] init];
    self.label.text = self.text?:@"渐变字体";
    [self.label setFont:self.font?:[UIFont systemFontOfSize:13]];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.label];
    

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.label setFrame:self.bounds];
    
    if (!self.gradientLayer.superlayer) {
        [self.layer addSublayer:self.gradientLayer];
    }
    self.gradientLayer.mask = self.label.layer;
}

@end
