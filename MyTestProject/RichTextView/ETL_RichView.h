//
//  ETL_RichView.h
//  MyTestProject
//
//  Created by GT-iOS on 2018/1/19.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ETL_RichViewDelegate <NSObject>

- (void)introViewDidChangeContenHeight;

@end

@interface ETL_RichView : UIView
@property (nonatomic, weak) id<ETL_RichViewDelegate> delegate;
@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, strong) CALayer *lineLayer;
@end
