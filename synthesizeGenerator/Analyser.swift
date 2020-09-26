//
//  Analyser.swift
//  synthesizeGenerator
//
//  Created by wangyang on 2020/9/24.
//  Copyright © 2020 动词大词典. All rights reserved.
//

import Foundation

// 做基础的解析，然后派发给更具体的解析器解析
class Analyser {
    static func parse(text: String) -> String {
        let propertys = text.components(separatedBy: "\n").filter { (line) -> Bool in
            return line.hasPrefix("@property")
        }
        
        var result = ""
        for (index, line) in propertys.enumerated() {
            var synthesizeCode = ""
            if line.contains("*") {
                if line.contains("weak") {
                    
                } else {
                    synthesizeCode = NonWeakObjectProperty(string: line).synthesizeCode
                }
                
            } else if line.contains(" id ") {
                
            }
            result.append(synthesizeCode)
            if index != propertys.count - 1 {
                result.append("\n\n")
            }
        }

        return result
    }
}

/* 现在还不支持的修饰符
 - nullable一类修饰符
 - class
 - weak

 
 - 自定义getter | setter方法名修饰符 : getter和setter
 - 原子性修饰符:atomic | nonatomic

 - 读写性修饰符：readwrite | readonly

 - setter相关修饰符：assign | retain | copy

 
 # 属性数据类型
 - BOOL
 - block
 - id
 
 */
