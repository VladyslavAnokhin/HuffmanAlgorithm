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

    func test() {
        let nodeA = Huffman.Tree.Node(frequence: 1, type: .leaf(value: "a"))
        let nodeB = Huffman.Tree.Node(frequence: 2, type: .leaf(value: "b"))
        let nodeC = Huffman.Tree.Node(frequence: 3, type: .leaf(value: "c"))
        
        let nodeAB = Huffman.Tree.Node(frequence: 3, type: .node(left: nodeA, right: nodeB))
        
        let root = Huffman.Tree.Node(frequence: 6, type: .node(left: nodeAB, right: nodeC))
        
        let tree = Huffman.Tree(root: root)
        
        let result = Huffman.compressTree(tree: tree)
        
        XCTAssertFalse(result.isEmpty)
        
        XCTAssertEqual(2, Huffman.awakeInt16(from: Array(result[0..<16])), "Length of A path")
        XCTAssertEqual([false, false], Array(result[16..<18]), "Path to first value")
        XCTAssertEqual(97, Huffman.awakeInt16(from: Array(result[18..<34])), "int value for 'a' == 97")
        
        XCTAssertEqual(2, Huffman.awakeInt16(from: Array(result[34..<50])), "Length of B path")
        XCTAssertEqual([false, true], Array(result[50..<52]), "Path to first value")
        XCTAssertEqual(98, Huffman.awakeInt16(from: Array(result[52..<68])), "int value for 'b' == 98")
        
        XCTAssertEqual(1, Huffman.awakeInt16(from: Array(result[68..<84])), "Length of C path")
        XCTAssertEqual([true], Array(result[84..<85]), "Path to first value")
        XCTAssertEqual(99, Huffman.awakeInt16(from: Array(result[85..<101])), "int value for 'c' == 99")
      
    }
}
