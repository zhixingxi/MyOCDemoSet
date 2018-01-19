//
//  FontsizePickView.swift
//  TeacherA
//
//  Created by MQL-IT on 2017/8/23.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

import UIKit

@objc public protocol FontsizePickViewDelegate: class {
    @objc optional func didSelectedFontsize(_ pickView: FontsizePickView, _ size: Int)
    
}

fileprivate let cellId = "cellId"

open class FontsizePickView: UIView {
    open weak var delegate: FontsizePickViewDelegate?
    
    var selectedRow: Int = -1
    
    var currentSize: Int = 0 {
        didSet {
            selectedRow = trancelateSizeToRow(currentSize)
            tableView.reloadData()
        }
    }
    
    fileprivate let tableView: UITableView = {
        let myTable = UITableView(frame: CGRect.zero, style: .plain)
        return myTable
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI设置 && 工具
extension FontsizePickView {
    fileprivate func setup() {
        tableView.frame = self.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FontsizeSelectedCell.self, forCellReuseIdentifier: cellId)
        addSubview(tableView)
    }
    
    fileprivate func trancelateRowToSize(_ row: Int) -> Int {
        switch row {
        case 0: return row + 6
        case 1: return row + 4
        case 2: return row + 2
        case 3: return row
        default:
            return 4
        }
    }
    
    fileprivate func trancelateSizeToRow(_ size: Int) -> Int {
        switch size {
        case 6: return size - 6
        case 5: return size - 4
        case 4: return size - 2
        case 3: return 3
        default:
            return 2
        }
    }
}

// MARK: - UITableViewDelegate
extension FontsizePickView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedFontsize?(self, trancelateRowToSize(indexPath.row))
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return bounds.size.height / 4.0
    }
}

// MARK: - UITableViewDataSource
extension FontsizePickView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FontsizeSelectedCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FontsizeSelectedCell
        cell.configCell(indexPath.row, selectedRow)
        return cell
    }
}


/// FontsizeSelectedCell 自定义cell
class FontsizeSelectedCell: UITableViewCell {
    
    lazy var label: UILabel = {
       let lab = UILabel(frame: CGRect.zero)
        lab.textAlignment = .center
        lab.textColor = UIColor.black
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    func configCell(_ row: Int, _ selectedRow: Int) {
        
        switch row {
        case 0:
            label.text = "超大号"
        case 1:
            label.text = "大号"
        case 2:
            label.text = "默认"
        case 3:
            label.text = "小号"
        default: break
        }
        if row == selectedRow {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }
    
    private func setup() {
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

