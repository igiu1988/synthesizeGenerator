//
//  String+GM.swift
//  Gengmei
//
//  Created by wangyang on 2017/12/21.
//  Copyright © 2017年 更美互动信息科技有限公司. All rights reserved.
//

import Foundation

// MARK: - 字符串截取
extension String {

    // 截取字符串从开始到index
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self
        }

        return String(self[startIndex..<end_Index])
    }

    // 截取字符串从index到结束
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index) else {
            return self
        }
        return String(self[start_index..<endIndex])
    }

    // 切割字符串(区间范围 前闭后开)
    func sliceString(_ range: CountableRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        return String(self[startIndex..<endIndex])
    }

    // 切割字符串(区间范围 前闭后闭)
    func sliceString(_ range: CountableClosedRange<Int>) -> String {
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if endIndex.encodedOffset <= end_Index.encodedOffset {
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }

    // 校验字符串位置 是否合理，并返回String.Index
    func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }

    // 校验是否是合法的起始位置
    func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return validIndex(original: original)
    }
    
    // 校验是否是合法的结束位置
    func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return validIndex(original: original)
    }
}
