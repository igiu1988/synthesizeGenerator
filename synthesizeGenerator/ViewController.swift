//
//  ViewController.swift
//  synthesizeGenerator
//
//  Created by wangyang on 2017/5/27.
//  Copyright © 2017年 动词大词典. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    @IBOutlet var resultTextView: NSTextView!

    @IBAction func parse(_ sender: Any) {
        if let str = textView.textStorage?.string {
            let result = Analyser.parse(text: str)
            resultTextView.insertText(result, replacementRange: NSRange(location: 0, length: resultTextView.string.count))
        }
    }
}




