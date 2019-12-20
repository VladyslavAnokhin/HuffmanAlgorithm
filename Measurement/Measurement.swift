//
//  MeasureTestCase.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 21.12.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class MeasureTestCase: XCTestCase {
    
    var bundle: Bundle!
    
    override func setUp() {
        super.setUp()
        
        bundle = Bundle(for: classForCoder)
    }
    
    func testCompress() throws {
        let path = bundle.path(forResource: "lotr", ofType: "txt")
        let string = try String(contentsOfFile: path!, encoding: .utf8)
        
        _ = Huffman.compress(string: string)
    }
    
    func testDecompress() throws {
        let path = bundle.path(forResource: "lotr_compressed", ofType: "bin")!
        let compressed = try Data(contentsOf: URL(fileURLWithPath: path))
        
        _ = Huffman.decompress(data: compressed)
    }
}

