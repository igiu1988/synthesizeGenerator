//
//  synthesizeGeneratorTests.swift
//  synthesizeGeneratorTests
//
//  Created by wangyang on 2020/9/24.
//  Copyright © 2020 动词大词典. All rights reserved.
//

import XCTest
@testable import synthesizeGenerator

class synthesizeGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let result = ViewController.analyse(text: synthesizeGeneratorTests.inputText)
        XCTAssertTrue(result == synthesizeGeneratorTests.expectResult)
        
    }

    
    
    static let inputText = """
@property (nonatomic) UIViewController *visibleController;
"""
    
    
    
    static let expectResult = """
- (void)setVisibleController:(UIViewController *)visibleController {
    objc_setAssociatedObject(self, @selector(visibleController), visibleController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)visibleController {
    UIViewController *visibleController = objc_getAssociatedObject(self, @selector(visibleController));
    return visibleController;
}


"""

}


