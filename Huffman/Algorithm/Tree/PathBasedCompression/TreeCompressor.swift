//
//  TreeCoder.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 21.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {

    
    static func compressTree(tree: Tree) -> [Bool] {
        
        struct ValuePath {
            let path: [Bool]
            let value: Character
        }
        
        func preorder(node: Tree.Node?, path: [Bool] ) -> [ValuePath] {
            var result = [ValuePath]()
            
            if let value = node?.value {
                let pathResult = ValuePath(path: path, value: value)
                result.append(pathResult)
                return result
            }
            
            result.append(contentsOf: preorder(node: node?.left, path: path + [false]))
            result.append(contentsOf: preorder(node: node?.right, path: path + [true]))
            
            return result
        }
        let bitReader = BitReader()
        
        return preorder(node: tree.root,
                        path: [])
            .reduce(into: [Bool]()) { result, valuePath in
                
                let valueInInt = String(valuePath.value).utf16.map{UInt16($0)}.first!
                let valueInBit = bitReader.readBit(from: valueInInt)
                let countInBit = bitReader.readBit(from: UInt16(valuePath.path.count))
                
                result.append(contentsOf: countInBit)
                result.append(contentsOf: valuePath.path)
                result.append(contentsOf: valueInBit)
        }
    }
}
