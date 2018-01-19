//
//  ColorPickerView.swift
//  TeacherA
//
//  Created by MQL-IT on 2017/8/23.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

import UIKit

@objc public protocol ColorPickerViewDelegate: class {
    @objc optional func didSelectedFontColor(_ pickView: ColorPickerView, _ color: UIColor?)
    
}

open class ColorPickerView: UIView {
    open weak var delegate: ColorPickerViewDelegate?
    //MARK: - 属性
    
    fileprivate let colors: [UIColor] = {
        return [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.blue, UIColor.purple ,UIColor.black]
    }()
    
    fileprivate let colorBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        return btn
    }()
    
    fileprivate var touchPointX: CGFloat = 0 {
        didSet {
            trancelateToColor(touchPointX)
        }
    }
    
    fileprivate var selectedColor: UIColor? {

        didSet {
            colorBtn.backgroundColor = selectedColor
            if !((oldValue?.isEqual(selectedColor)) ?? false) {
                delegate?.didSelectedFontColor!(self, selectedColor)
            }
        }
    }
    
    //MARK: - 重写
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let t:UITouch = touch
            let touchPoint = t.location(in: self)
            if touches.count > 1 || t.tapCount > 1 || event?.allTouches?.count ?? 0 > 1 {
                return
            }
            if touchPoint.x > 15 && touchPoint.x < bounds.size.width - 60 {
                touchPointX = touchPoint.x
            }
            
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let t:UITouch = touch
            let touchPoint = t.location(in: self)
            if touches.count > 1 || t.tapCount > 1 || event?.allTouches?.count ?? 0 > 1 {
                return
            }
            if touchPoint.x > 15 && touchPoint.x < bounds.size.width - 60 {
                touchPointX = touchPoint.x
            }
            
        }
         self.isHidden = true
    }
    
    override open func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: bounds)
        path.lineWidth = 1.0;
        UIColor.white.setFill()
        UIColor(white: 0.9, alpha: 1.0).setStroke()
        path.fill()
        path.stroke()
        super.draw(rect)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI设置
extension ColorPickerView {
    
    fileprivate func setup() {
        selectedColor = UIColor.black
        let itemWidth = (bounds.size.width  - 75) / CGFloat(colors.count)
        let itemHeight = bounds.size.height / 5.0
        let _: CGFloat = colors.reduce(15) { (sofar, newColor) in
            let mylayer = CALayer()
            mylayer.backgroundColor = newColor.cgColor
            mylayer.frame = CGRect(x: CGFloat(sofar), y: bounds.size.height * 2 / 5.0, width: itemWidth, height: itemHeight)
            layer.addSublayer(mylayer)
            return (CGFloat(sofar) + itemWidth)
        }
        
        colorBtn.frame = CGRect(x: bounds.width - 45, y: 20, width: 30, height: 30)
        addSubview(colorBtn)
    }
    
    
    fileprivate func trancelateToColor(_ x: CGFloat) {
        let itemWidth = (bounds.size.width  - 75) / CGFloat(colors.count)
        let idx = Int((x - 15) / itemWidth)
        if idx >= 0 && idx < colors.count {
            selectedColor = colors[idx]
        }
    }
}




