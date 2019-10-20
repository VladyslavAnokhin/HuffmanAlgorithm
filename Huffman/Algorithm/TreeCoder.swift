//
//  TreeCoder.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 21.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    
    struct ValuePath {
        let path: [Bool]
        let value: Character
    }
    
    static func compressTree(tree: Tree) -> [ValuePath] {
        
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
        
        return preorder(node: tree.root, path: [])
    }
}
