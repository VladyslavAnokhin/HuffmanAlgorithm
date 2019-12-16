//
//  Decompressor.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    
   
    class Decompressor {
        let tree: Tree
        
        init(tree: Tree) {
            self.tree = tree
        }
        
        func decompress(bits: [Bool]) -> String {
            guard let root = tree.root else { fatalError() }
            var currentNode = root
            
            return bits.reduce(into: "") {  result, bit in
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
        }
    }
}


