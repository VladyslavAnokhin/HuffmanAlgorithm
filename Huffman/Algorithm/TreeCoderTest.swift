//
//  TreeCoderTest.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 21.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class TreeCoderTest: XCTestCase {

    func testFindAllValues() {
        let nodeA = Huffman.Tree.Node(frequence: 1, value: "a")
        let nodeB = Huffman.Tree.Node(frequence: 2, value: "b")
        let nodeC = Huffman.Tree.Node(frequence: 3, value: "c")
        
        let nodeAB = Huffman.Tree.Node(frequence: 3, value: nil, left: nodeA, right: nodeB)
        
        let root = Huffman.Tree.Node(frequence: 6, value: nil, left: nodeAB, right: nodeC)
        let tree = Huffman.Tree(root: root)
        
        let result = Huffman.compressTree(tree: tree)
        
        let aPath = result.first { $0.value == "a" }
        let bPath = result.first { $0.value == "b" }
        let cPath = result.first { $0.value == "c" }
        
        XCTAssertEqual(aPath?.path, [false, false])
        XCTAssertEqual(aPath?.value, "a")
        
        XCTAssertEqual(bPath?.path, [false, true])
        XCTAssertEqual(bPath?.value, "b")
        
        XCTAssertEqual(cPath?.path, [true])
        XCTAssertEqual(cPath?.value, "c")
        
        XCTAssertEqual(result.count, 3)
    }
}
