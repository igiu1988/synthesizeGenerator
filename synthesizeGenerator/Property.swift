//
//  Property.swift
//  synthesizeGenerator
//
//  Created by wy on 2020/9/24.
//  Copyright © 2020 北京动词大词典. All rights reserved.
//

import Foundation

enum PropertyType: String {
    case float = "CGFloat"
    case size = "CGSize"
    case block = "^"
    case cls = "*"
}

// TODO: 缺少对BOOL，数字类型的支持 CGSize, CGFloat, block
class Property {
    var name = ""
    var value = ""
    var type = ""
    var method = ""
    var isPointer = false
    var associationPolicy = ""
    var typeName = ""
    var propertyType: PropertyType!

    var setter: String {
        var result = "- (void)set\(self.name.capitalizingFirstLetter()):(\(self.typeName))\(self.name) {\n"
        result.append("    objc_setAssociatedObject(self, @selector(\(self.name)), \(self.value), \(self.associationPolicy));\n")
        result.append("}")
        return result
    }

    var getter: String {
        var result = "- (\(self.typeName))\(self.name) {\n"
        result.append("    \(self.type) *\(self.name) = objc_getAssociatedObject(self, @selector(\(self.name)));\n")
        result.append("    return \(self.name);\n")
        result.append("}")
        return result
    }

    init(string: String) {

        let components = string.components(separatedBy: " ")
        self.name = components.last!
        self.name.remove(at: string.index(self.name.endIndex, offsetBy: -1)) // 去掉分号
        self.type = components[components.count - 2]

        if string.contains("*") {
            self.isPointer = true
            self.typeName = self.type + " *"
            self.name.remove(at: self.name.startIndex)
            self.value = self.name
        } else {
            self.typeName = self.type + " "
            self.value = "@(\(self.name))"
            switch self.typeName {
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
