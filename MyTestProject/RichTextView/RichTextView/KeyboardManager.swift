
//
//  KeyboardManager.swift
//  TeacherA
//
//  Created by MQL-IT on 2017/8/21.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

import UIKit

/**
 KeyboardManager is a class that takes care of showing and hiding the RichEditorToolbar when the keyboard is shown.
 As opposed to having this logic in multiple places, it is encapsulated in here. All that needs to change is the parent view.
 */
class KeyboardManager: NSObject {
    
    var keyboardHeight: CGFloat = 0 {
        didSet {
            var tempFrame = toolbar.editor?.frame
            tempFrame?.size.height = UIScreen.main.bounds.size.height - 64 - keyboardHeight
            toolbar.editor?.frame = tempFrame ?? CGRect.zero
        }
    }
    
    fileprivate lazy var fontSizeView: FontsizePickView = FontsizePickView(frame: CGRect.zero)
    fileprivate lazy var fontColorView: ColorPickerView = ColorPickerView(frame: CGRect(x: 0, y: self.toolbar.frame.maxY, width: UIScreen.main.bounds.size.width, height: 70))
    
    fileprivate var keyboardWindow: UIWindow? {
        didSet {
            guard let keyboard = keyboardWindow else { return }
            keyboard.addSubview(fontSizeView)
            fontSizeView.isHidden = true
            keyboard.addSubview(fontColorView)
            fontColorView.isHidden = true
        }
    }
    /**
     The parent view that the toolbar should be added to.
     Should normally be the top-level view of a UIViewController
     */
    weak var view: UIView?
    
    /**
     The toolbar that will be shown and hidden.
     */
    @objc var toolbar: RichEditorToolbar
    
    @objc init(view: UIView) {
        self.view = view
        toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 44))
        toolbar.options = RichEditorDefaultOption.customFunction
    }
    
    
    
    /**
     Starts monitoring for keyboard notifications in order to show/hide the toolbar
     */
    @objc func beginMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardWillShowOrHide(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardWillShowOrHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /**
     Stops monitoring for keyboard notifications
     */
    @objc func stopMonitoring() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /**
     Called when a keyboard notification is recieved. Takes are of handling the showing or hiding of the toolbar
     */
    @objc func keyboardWillShowOrHide(_ notification: Notification) {
        
        let info = (notification as NSNotification).userInfo ?? [:]
        let duration = TimeInterval((info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.floatValue ?? 0.25)
        let curve = UInt((info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0)
        let options = UIViewAnimationOptions(rawValue: curve)
        let keyboardRect = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        keyboardHeight = keyboardRect.size.height + self.toolbar.frame.height
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            self.view?.addSubview(self.toolbar)
            
            for window in UIApplication.shared.windows {
                if window.isMember(of: NSClassFromString("UIRemoteKeyboardWindow")!) {
                    keyboardWindow = window
                }
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                if let view = self.view {
                    self.toolbar.frame.origin.y = view.frame.height - (keyboardRect.height + self.toolbar.frame.height)
                }
            }, completion: nil)
            
            
        } else if notification.name == NSNotification.Name.UIKeyboardWillHide {
            keyboardHeight = 0
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.fontSizeView.isHidden = true
                if let view = self.view {
                    self.toolbar.frame.origin.y = view.frame.height
                }
            }, completion: nil)
        }
    }
}

fileprivate let screenHeight = UIScreen.main.bounds.size.height
fileprivate let screenWidth = UIScreen.main.bounds.size.width
// MARK: - 处理自定义键盘- 字体大小
extension KeyboardManager: FontsizePickViewDelegate {
    @objc func FontsizePickerViewShow() {
        fontSizeView.isHidden = !fontSizeView.isHidden
        if fontSizeView.isHidden {
            return
        }
        fontSizeView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight - toolbar.frame.maxY)
        fontSizeView.delegate = self
        fontSizeView.isHidden = false
        fontSizeView.currentSize = self.toolbar.editor?.getMyFontSize() ?? 4
        UIView.animate(withDuration: 0.3) { 
            self.fontSizeView.frame = CGRect(x: 0, y: self.toolbar.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.toolbar.frame.maxY)
        }
    }
    
    func didSelectedFontsize(_ pickView: FontsizePickView, _ size: Int) {
        self.toolbar.editor?.setMyFontSize(size)
        fontSizeView.isHidden = true
    }
}

// MARK: - 处理自定义键盘- 字体颜色
extension KeyboardManager: ColorPickerViewDelegate {
    @objc func fontColorPickerViewShow() {
        
        fontColorView.isHidden = !fontColorView.isHidden
        fontColorView.delegate = self;
        fontColorView.frame = CGRect(x: 0, y: self.toolbar.frame.minY - 70, width: UIScreen.main.bounds.size.width, height: 70)
    }
    
    func didSelectedFontColor(_ pickView: ColorPickerView, _ color: UIColor?) {
        self.toolbar.editor?.setTextColor(color ?? UIColor.black)
    }
}

