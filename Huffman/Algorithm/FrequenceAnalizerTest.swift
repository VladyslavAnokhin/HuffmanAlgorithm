//
//  FrequenceAnalizerTest.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class FrequenceAnalizerTest: XCTestCase {
    
    let sut = Huffman.analize
    
    func testSymbol() {
        let single = "a"
        
        let result = sut(single)
        
        XCTAssertEqual(result["a"], 1)
    }
    
    func testDouble() {
        let double = "aa"
        
        let result = sut(double)
        
        XCTAssertEqual(result["a"], 2)
    }
    
    func testDifferentSymbols() {
        let str = "abcab"
        
        let result = sut(str)
        
        XCTAssertEqual(result["a"], 2)
        XCTAssertEqual(result["b"], 2)
        XCTAssertEqual(result["c"], 1)
    }

}
