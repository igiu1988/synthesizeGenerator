//
//  ViewController.swift
//  synthesizeGenerator
//
//  Created by wangyang on 2017/5/27.
//  Copyright © 2017年 北京动词大词典. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!

    @IBOutlet var resultTextView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func parse(_ sender: Any) {

        let str = textView.textStorage!.string
        let propertys = str.components(separatedBy: "\n").filter { (line) -> Bool in
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
        resultTextView.insertText(result, replacementRange: NSRange(location: 0, length: resultTextView.string.count))
    }
}




