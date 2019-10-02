//
//  Decompressor.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    
    class BitReader {
        
        func readBit(from data: Data) -> [Bool] {
            return data.map { byte -> [Bool] in
                let bitsOfAbyte = 8
                var bitsArray = [Bool](repeating: false, count: bitsOfAbyte)
                for (index, _) in bitsArray.enumerated() {
                    // Bitwise shift to clear unrelevant bits
                    let bitVal: UInt8 = 1 << UInt8(bitsOfAbyte - 1 - index)
                    let check = byte & bitVal
                    bitsArray[index] = check != 0
                }
                    
                return bitsArray
            }.reduce(into: []) { (result, array) in
                result.append(contentsOf: array)
            }
        }
    }
    
    class Decompressor {
        let tree: Tree
        
        init(tree: Tree) {
            self.tree = tree
        }
        
        func decompress(data: Data) -> String {
            guard let root = tree.root else { fatalError() }
            var currentNode = root
            var result = ""
            
            BitReader()
                .readBit(from: data)
                .forEach { bit in
                    if bit == false,
                        let left = currentNode.left {
                        currentNode = left
                    } else if bit == true,
                        let right = currentNode.right {
                        currentNode = right
                    } else {
                        fatalError()
                    }
                    
                    if let value = currentNode.value {
                        result += String(value)
                        currentNode = root
                    }
                }
            
            return result
        }
    }
}


