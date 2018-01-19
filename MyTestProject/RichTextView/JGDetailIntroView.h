//
//  JGDetailIntroView.h
//  TeacherA
//
//  Created by MQL-IT on 2017/9/5.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JGDetailIntroViewDelegate <NSObject>

- (void)introViewDidChangeContenHeight;

@end

@interface JGDetailIntroView : UIView
@property (nonatomic, weak) id<JGDetailIntroViewDelegate> delegate;
@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, strong) CALayer *lineLayer;
@end
