//
//  ETL_RichTextView.swift
//  MyTestProject
//
//  Created by GT-iOS on 2018/1/19.
//  Copyright © 2018年 GT-iOS. All rights reserved.
//
import UIKit
@objc public protocol ETL_RichTextViewDelegate: class {
    
    /// Called when the inner height of the text being displayed changes
    /// Can be used to update the UI
    @objc optional func richEditor(_ editor: ETL_RichTextView, heightDidChange height: Int)
}
open class ETL_RichTextView: UIView, UIScrollViewDelegate, UIWebViewDelegate {
    @objc open weak var delegate: ETL_RichTextViewDelegate?
    
    open private(set) var webView: UIWebView
    
    open private(set) var editorHeight: Int = 0 {
        didSet {
            delegate?.richEditor?(self, heightDidChange: editorHeight)
            
        }
    }
    open private(set) var contentHTML: String = ""
    private var isEditorLoaded = false
    private var innerLineHeight: Int = 28
    open private(set) var lineHeight: Int {
        get {
            if isEditorLoaded, let lineHeight = Int(runJS("RE.getLineHeight();")) {
                return lineHeight
            } else {
                return innerLineHeight
            }
        }
        set {
            innerLineHeight = newValue
            let _ = runJS("RE.setLineHeight('\(innerLineHeight)px');")
        }
    }
    
    public override init(frame: CGRect) {
        webView = UIWebView()
        webView.clipsToBounds = true
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        webView = UIWebView()
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        webView.frame = bounds
        webView.delegate = self
        webView.keyboardDisplayRequiresUserAction = false
        webView.scalesPageToFit = false
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.dataDetectorTypes = UIDataDetectorTypes()
        webView.backgroundColor = .white
        webView.scrollView.bounces = false
        webView.scrollView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.clipsToBounds = false
        
        self.addSubview(webView)
        
        if let filePath = Bundle(for: ETL_RichTextView.self).path(forResource: "rich_editor", ofType: "html") {
            let url = URL(fileURLWithPath: filePath, isDirectory: false)
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    @objc public var html: String {
        get {
            return runJS("RE.getHtml();")
        }
        set {
            contentHTML = newValue
            let _ = runJS("RE.setHtml('\(newValue.escaped)');")
            updateHeight()
        }
    }
    
    public func runJS(_ js: String) -> String {
        let string = webView.stringByEvaluatingJavaScript(from: js) ?? ""
        return string
    }
    
    private func updateHeight() {
        let heightString = runJS("document.getElementById('editor').clientHeight;")
        let height = Int(heightString) ?? 0
        if editorHeight != height {
            editorHeight = height
        }
    }

}

extension ETL_RichTextView {
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // Handle pre-defined editor actions
        let callbackPrefix = "re-callback://"
        if request.url?.absoluteString.hasPrefix(callbackPrefix) == true {
            
            // When we get a callback, we need to fetch the command queue to run the commands
            // It comes in as a JSON array of commands that we need to parse
            let commands = runJS("RE.getCommandQueue();")
            
            if let data = commands.data(using: .utf8) {
                
                let jsonCommands: [String]
                do {
                    jsonCommands = try JSONSerialization.jsonObject(with: data) as? [String] ?? []
                } catch {
                    jsonCommands = []
                    NSLog("RichEditorView: Failed to parse JSON Commands")
                }
                
                jsonCommands.forEach(performCommand)
            }
            
            return false
        }
        
        return true
    }
    
    private func performCommand(_ method: String) {
       
        updateHeight()
        if method.hasPrefix("ready") {
            // If loading for the first time, we have to set the content HTML to be displayed
            if !isEditorLoaded {
                isEditorLoaded = true
                html = contentHTML
                lineHeight = innerLineHeight
            }
            updateHeight()
        }else if method.hasPrefix("updateHeight") {
            updateHeight()
        }
    }
}
