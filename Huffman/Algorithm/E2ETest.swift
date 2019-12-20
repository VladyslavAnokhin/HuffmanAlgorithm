//
//  E2ETest.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class E2ETest: XCTestCase {
    
    func testInterface() {
        let text = "Hello World!!!"
        let compressed = Huffman.compress(string: text)
        let decompressed = Huffman.decompress(data: compressed)
        XCTAssertEqual(decompressed, text)
    }
}
