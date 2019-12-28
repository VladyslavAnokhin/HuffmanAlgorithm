//
//  TreeConverterTest.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 03.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class TreeConverterTest: XCTestCase {

    func test() {
        let nodeA = Huffman.Tree.Node(frequence: 1, type: .leaf(value: "a"))
        let nodeB = Huffman.Tree.Node(frequence: 2, type: .leaf(value: "b"))
        let nodeC = Huffman.Tree.Node(frequence: 3, type: .leaf(value: "c"))
        
        let nodeAB = Huffman.Tree.Node(frequence: 3, type: .node(left: nodeA, right: nodeB))
        
        let root = Huffman.Tree.Node(frequence: 6, type: .node(left: nodeAB, right: nodeC))
        let tree = Huffman.Tree(root: root)
        
        let result = Huffman.convertTreeToCodesTable(tree: tree)
        
        XCTAssertEqual(result["a"], [false, false])
        XCTAssertEqual(result["b"], [false, true])
        XCTAssertEqual(result["c"], [true])
    }

}
