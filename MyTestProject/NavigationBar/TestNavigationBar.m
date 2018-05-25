//
//  TestNavigationBar.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/5/25.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//  git@github.com:spicyShrimp/UINavigation-SXFixSpace.git

#import "TestNavigationBar.h"

@implementation TestNavigationBar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //iOS11之后就不管用了
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
//    item.width = 60;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItems:@[left]];
    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:NO];
}
@end
