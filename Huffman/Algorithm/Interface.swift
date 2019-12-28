//
//  Interface.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

enum Huffman {
    static func compress(string: String) -> Data {

        let nodes = analize(string: string)
            .map { Tree.Node(frequence: $0.value, type: .leaf(value: $0.key)) }
        let tree = Tree(array: nodes)
        
        let codesTable = convertTreeToCodesTable(tree: tree)
        let compressor = Compressor(codesTables: codesTable)
        
        let bitWriter = BitWriter()
        
        let compressedTree = compressTree(tree: tree)
        let compressedValue = compressor.compress(text: string)
        
        let numberForTailInfoBits = 3
        let tail = UInt8(8 - ((compressedTree.count + compressedValue.count + numberForTailInfoBits) % 8))
        let tailInBits = BitReader().readBit(from: tail)[5..<8]
        let treeSizeInBits = BitReader().readBit(from: UInt16(compressedTree.count))
        
        tailInBits.forEach(bitWriter.writeBit)
        treeSizeInBits.forEach(bitWriter.writeBit)
        compressedTree.forEach(bitWriter.writeBit)
        compressedValue.forEach(bitWriter.writeBit)
        
        bitWriter.flush()
        
        return bitWriter.data as Data
    }
    
    static func decompress(data: Data) -> String {
        let bits = BitReader().readBit(from: data)
        let tail = Huffman.awakeInt(from: Array(bits[0..<3]))
        let treeSize = Huffman.awakeInt(from: Array(bits[3..<19]))
        let treeBits = Array(bits[19..<treeSize+19])
        let valueBits = Array(bits[treeSize+19..<bits.count-tail])
        
        let tree = decmopressTree(array: treeBits)
        let decompressor = Decompressor(tree: tree)
        let value = decompressor.decompress(bits: valueBits)
        return value
    }
}
