//
//  RichEditorToolbar.swift
//  TeacherA
//
//  Created by MQL-IT on 2017/8/22.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

import UIKit
@objc public protocol RichEditorToolbarDelegate: class {
    @objc optional func richEditorToolbarChangeTextFont(_ toolbar: RichEditorToolbar)
    
    /// Called when the Text Color toolbar item is pressed.
    @objc optional func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar)
    
    /// Called when the Background Color toolbar item is pressed.
    @objc optional func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar)
    
    /// Called when the Insert Image toolbar item is pressed.
    @objc optional func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar)
    
    /// Called when the Insert Link toolbar item is pressed.
    @objc optional func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar)
    //显示键盘
    @objc optional func richEditorToolbarDisplayKeyboard(_ toolbar: RichEditorToolbar)
}

open class RichEditorToolbar: UIView {
    @objc open weak var delegate: RichEditorToolbarDelegate?
    
    /// A reference to the RichEditorView that it should be performing actions on
    @objc open weak var editor: RichEditorView?
    
    /// The list of options to be displayed on the toolbar
    open var options: [RichEditorOption] = [] {
        didSet {
            updateToolbar()
        }
    }
    
    private var toolbarScroll: UIScrollView
    private var toolbar: UIView
    
    public override init(frame: CGRect) {
        toolbarScroll = UIScrollView()
        toolbar = UIView()
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.white
        autoresizingMask = .flexibleWidth
        backgroundColor = .clear
        toolbar.autoresizingMask = .flexibleWidth
        toolbar.backgroundColor = .clear
        
        toolbarScroll.frame = bounds
        toolbarScroll.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        toolbarScroll.showsHorizontalScrollIndicator = false
        toolbarScroll.showsVerticalScrollIndicator = false
        toolbarScroll.backgroundColor = .clear
        
        toolbarScroll.addSubview(toolbar)
        addSubview(toolbarScroll)
        updateToolbar()
    }
    
    
    private func updateToolbar() {
        var buttons = [RichBarButtonItem]()
        for option in options {
            let handler = { [weak self] in
                if let strongSelf = self {
                    option.action(strongSelf)
                }
            }
            let button = RichBarButtonItem(image: option.image, text: option as? RichEditorDefaultOption, handler: handler)
            buttons.append(button)
        }
        for view in toolbar.subviews {
            view.removeFromSuperview()
        }
        let itemWidth = (UIScreen.main.bounds.size.width - 100) / CGFloat(buttons.count)
        let width: CGFloat = buttons.reduce(50) { sofar, new in
            new.frame = CGRect(x: CGFloat(sofar), y: 0.5, width: itemWidth, height: 44 - 1)
            toolbar.addSubview(new)
            return (CGFloat(sofar) + itemWidth)
        }
        toolbar.frame = bounds
        toolbarScroll.contentSize.width = width
    }
    
    open override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0.5))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0.5))
        path.move(to: CGPoint(x: 0, y: rect.maxY - 0.5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 0.5))
        path.lineWidth = 1.0;
        UIColor(white: 0.9, alpha: 1.0).setStroke()
        path.stroke()
        super.draw(rect)
    }
}



open class RichBarButtonItem: UIButton {
    open var actionHandler: (() -> Void)?
    
    public convenience init(image: UIImage? = nil,
                            text: RichEditorDefaultOption? = nil,
                            handler: (() -> Void)? = nil) {
        self.init()
        if text?.title == "Bold" || text?.title == "Underline" {
            self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .selected)
        }
        self.backgroundColor = UIColor.white
        self.setImage(image, for: .normal)
        let width = UIScreen.main.bounds.size.width / 6.0
        self.frame = CGRect(x: 0, y: 0.5, width: width, height: 44 - 1)
        self.addTarget(self, action: #selector(RichBarButtonItem.buttonWasTapped), for: .touchUpInside)
        actionHandler = handler
    }
    
    @objc func buttonWasTapped(_ sender: UIButton) {
        sender.tintColor = UIColor.purple
        sender.isSelected = !(sender.isSelected)
        actionHandler?()
    }
}
