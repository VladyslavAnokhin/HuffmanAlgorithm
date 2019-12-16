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

    let text = "Hello World!!!"
    var compressor: Huffman.Compressor!
    var decompressor: Huffman.Decompressor!
    
    override func setUp() {
        let frequence = Huffman.analize(string: text)
        let nodes = frequence.map { Huffman.Tree.Node(frequence: $0.value, value: $0.key) }
        let tree = Huffman.Tree(array: nodes)
        let codes = Huffman.convertTreeToCodesTable(tree: tree)
        compressor = Huffman.Compressor(codesTables: codes)
        decompressor = Huffman.Decompressor(tree: tree)
    }
    
    func testInterface() {
        let compressed = Huffman.compress(string: text)
        let decompressed = Huffman.decompress(data: compressed)
        XCTAssertEqual(decompressed, text)
    }

}
