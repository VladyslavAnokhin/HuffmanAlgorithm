//
//  TreeDecoderTest.swift
//  HuffmanTests
//
//  Created by Vladyslav Anokhin on 21.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import XCTest
@testable import Huffman

class TreeDecoderTest: XCTestCase {

    func test() {
        /*
             Tree graph
                 *
                / \
               *   c
              / \
             a   b
         */
        
        let lengthOfPathA = Huffman.BitReader().readBit(from: UInt16(2))
        let pathToValueA = [false, false]
        let A = Huffman.BitReader().readBit(from: UInt16(97))
        
        let lengthOfPathB = Huffman.BitReader().readBit(from: UInt16(2))
        let pathToValueB = [false, true]
        let B = Huffman.BitReader().readBit(from: UInt16(98))
        
        let lengthOfPathC = Huffman.BitReader().readBit(from: UInt16(1))
        let pathToValueC = [true]
        let C = Huffman.BitReader().readBit(from: UInt16(99))
        
        var input = [Bool]()
        
        input.append(contentsOf: lengthOfPathA)
        input.append(contentsOf: pathToValueA)
        input.append(contentsOf: A)
        
        input.append(contentsOf: lengthOfPathB)
        input.append(contentsOf: pathToValueB)
        input.append(contentsOf: B)
        
        input.append(contentsOf: lengthOfPathC)
        input.append(contentsOf: pathToValueC)
        input.append(contentsOf: C)
        
        let sut = Huffman.decmopressTree(array: input)
        XCTAssertNotNil(sut.root)
        
        let cNode = sut.root?.right
        XCTAssertNotNil(cNode)
        XCTAssertEqual(cNode?.value, "c")
        
        let aNode = sut.root?.left?.left
        XCTAssertNotNil(aNode)
        XCTAssertEqual(aNode?.value, "a")
        
        let bNode = sut.root?.left?.right
        XCTAssertNotNil(bNode)
        XCTAssertEqual(bNode?.value, "b")
    }
}
