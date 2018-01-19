//
//  QLTestController.h
//  TeacherA
//
//  Created by MQL-IT on 2017/8/21.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RichEditorView, KeyboardManager;

@interface QLTestController : UIViewController
@property (nonatomic, strong)  RichEditorView *editorView;
@property (nonatomic, strong)  UITextView *htmlTextView;

// The keyboardManager allows us to display the toolbar
// However, some of the features of the RichEditorToolbar are not supported from Objective-C
@property (nonatomic, strong) KeyboardManager *keyboardManager;
@end
