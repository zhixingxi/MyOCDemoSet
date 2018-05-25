//
//  UINavigationBar+MQLFixSpace.m
//  MyTestProject
//
//  Created by GT-iOS on 2018/5/25.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import "UINavigationBar+MQLFixSpace.h"

#import <objc/runtime.h>

@implementation UINavigationBar (MQLFixSpace)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method m1 = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method m2 = class_getInstanceMethod(self, @selector(sx_layoutSubviews));
        method_exchangeImplementations(m1, m2);
    });
}

-(void)sx_layoutSubviews{
    [self sx_layoutSubviews];
    CGFloat version = [UIDevice currentDevice].systemVersion.floatValue;
    if (version >= 11) {
        self.layoutMargins = UIEdgeInsetsZero;
        CGFloat space = -10;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);//可修正iOS11之后的偏移
                break;
            }
        }
    }
}
@end
