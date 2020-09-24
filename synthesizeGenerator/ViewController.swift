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
            let result = ViewController.analyse(text: str)
            resultTextView.insertText(result, replacementRange: NSRange(location: 0, length: resultTextView.string.count))
        }
    }

    static func analyse(text: String) -> String {
        let propertys = text.components(separatedBy: "\n").filter { (line) -> Bool in
            return line.hasPrefix("@property")
        }

        var result = ""
        for line in propertys {
            let property = Property(string: line)
            result.append(property.setter)
            result.append("\n\n")
            result.append(property.getter)
            result.append("\n\n")
        }
        return result
    }
}




