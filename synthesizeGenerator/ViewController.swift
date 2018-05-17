//
//  ViewController.swift
//  synthesizeGenerator
//
//  Created by wangyang on 2017/5/27.
//  Copyright © 2017年 北京更美互动信息科技有限公司. All rights reserved.
//

import Cocoa
// TODO: CGSize
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
            result.append("\n")
            result.append(property.getter)
            result.append("\n")
        }
        resultTextView.insertText(result, replacementRange: NSRange(location: 0, length: resultTextView.string!.characters.count))
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// TODO: 缺少对BOOL，数字类型的支持
class Property {
    var name = ""
    var value = ""
    var type = ""
    var method = ""
    var isPointer = false
    var associationPolicy = ""
    var setter: String {
        if self.isPointer {
            var result = "- (void)set\(self.name.capitalizingFirstLetter()):(\(self.type ) *)\(self.name) {\n"
            result.append("    objc_setAssociatedObject(self, @selector(\(self.name)), \(self.value), \(self.associationPolicy));")
            result.append("\n}")
            return result
        } else {
            var result = "- (void)set\(self.name.capitalizingFirstLetter()):(\(self.type))\(self.name) {\n"
            result.append("    objc_setAssociatedObject(self, @selector(\(self.name)), \(self.value), \(self.associationPolicy));")
            result.append("\n}")
            return result
        }

    }

    var getter: String {
        if self.isPointer {
            var result = "- (\(self.type) *)\(self.name) {\n"
            result.append("    \(self.type) *_\(self.name) = objc_getAssociatedObject(self, @selector(\(self.name)));\n")
            result.append("    if (_\(self.name) == nil) {\n")
            result.append("        return [\(self.type) new];\n")
            result.append("    } else {\n")
            result.append("        return _\(self.name);\n")
            result.append("    }")
            result.append("\n}")
            return result
        } else {
            var result = "- (\(self.type))\(self.name) {\n"
            result.append("    NSNumber *_\(self.name) = objc_getAssociatedObject(self, @selector(\(self.name)));\n")
            result.append("    if (_\(self.name) == nil) {\n")
            result.append("        return 0;\n")
            result.append("    } else {\n")
            result.append("        return [_\(self.name) \(self.method)];\n")
            result.append("    }")
            result.append("\n}")
            return result
        }

    }

    init(string: String) {

        let components = string.components(separatedBy: " ")
        self.name = components.last!
        self.name.remove(at: string.index(self.name.endIndex, offsetBy: -1)) // 去掉分号
        self.type = components[components.count - 2]

        if string.contains("*") {
            self.isPointer = true
            self.name.remove(at: self.name.startIndex)
            self.value = self.name
        } else {
            self.value = "@(\(self.name))"
            switch self.type {
            case "CGFloat":
                self.method = "doubleValue"
            case "double":
                self.method = "doubleValue"
            case "Int":
                self.method = "intValue"
            case "NSInteger":
                self.method = "integerValue"
            case "NSUInteger":
                self.method = "unsignedIntegerValue"
            case "float":
                self.method = "floatValue"
            case "BOOL":
                self.method = "boolValue"
            default:
                self.method = "unexpectedMethod"
            }
        }

        self.associationPolicy = "OBJC_ASSOCIATION_RETAIN_NONATOMIC"
        if string.contains("weak") {
            self.associationPolicy = "OBJC_ASSOCIATION_ASSIGN"
        }
        if string.contains("copy") {
            self.associationPolicy = "OBJC_ASSOCIATION_COPY_NONATOMIC"
        }

    }
}

