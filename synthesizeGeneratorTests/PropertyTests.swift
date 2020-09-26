//
//  PropertyTests.swift
//  synthesizeGeneratorTests
//
//  Created by wangyang on 2020/9/26.
//  Copyright © 2020 动词大词典. All rights reserved.
//

import XCTest
@testable import synthesizeGenerator

// 检验各种属性是否正确解析
class PropertyTests: XCTestCase {

    func testPointerProperty() {
        let property = PointTypeProperty(string: "@property(nonatomic, strong) NSArray *myArray;")
        let result = """
- (void)setMyArray:(NSArray *)myArray {
    objc_setAssociatedObject(self, @selector(myArray), myArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)myArray {
    NSArray *myArray = objc_getAssociatedObject(self, @selector(myArray));
    return myArray;
}
"""
        XCTAssertTrue(result == property.synthesizeCode)
    }

}
