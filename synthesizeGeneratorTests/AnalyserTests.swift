//
//  AnalyserTests.swift
//  synthesizeGeneratorTests
//
//  Created by wangyang on 2020/9/26.
//  Copyright © 2020 动词大词典. All rights reserved.
//

import XCTest
@testable import synthesizeGenerator

class AnalyserTests: XCTestCase {

    // 只检验输出格式（是否正确分行）
    func testAnalyserOutputFormat() {
        let input = """
@property(nonatomic, strong) NSArray *myArray;
@property(nonatomic, strong) NSArray *otherArray;
"""
        let result = """
- (void)setMyArray:(NSArray *)myArray {
    objc_setAssociatedObject(self, @selector(myArray), myArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)myArray {
    NSArray *myArray = objc_getAssociatedObject(self, @selector(myArray));
    return myArray;
}

- (void)setOtherArray:(NSArray *)otherArray {
    objc_setAssociatedObject(self, @selector(otherArray), otherArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)otherArray {
    NSArray *otherArray = objc_getAssociatedObject(self, @selector(otherArray));
    return otherArray;
}
"""
        XCTAssertEqual(Analyser.parse(text: input), result)
        
    }

}
