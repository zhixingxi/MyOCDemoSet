//
//  ETL_CheckProtocolView.h
//  etiaolong
//
//  Created by GT-iOS on 2018/1/18.
//  Copyright © 2018年 etiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ETL_CheckProtocolViewDelegate <NSObject>
- (void)didClickProtocolString:(NSString *)str;
@end

@interface ETL_CheckProtocolView : UIView
- (instancetype)initWithFrame:(CGRect)frame string:(NSString *)string checkStrings:(NSArray *)stringValues;
@property (nonatomic, weak)id<ETL_CheckProtocolViewDelegate> delegate;
@property (nonatomic, assign) BOOL isChecked;
@end
