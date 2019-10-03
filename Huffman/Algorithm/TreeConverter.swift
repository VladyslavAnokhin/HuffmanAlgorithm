//
//  TreeConverter.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 03.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    static func convertTreeToCodesTable(tree: Tree) -> [Character: [Bool]] {
        func toTable(node: Tree.Node?, path: [Bool]) -> [Character: [Bool]] {
            guard let node = node else { return [:] }
            if let value = node.value {
                return [value: path]
            }
            
            let left = toTable(node: node.left, path: path + [false] )
            var right = toTable(node: node.right, path: path + [true] )
            
            left.forEach {
                right[$0.key] = $0.value
            }
            
            return right
        }
        
        return toTable(node: tree.root, path: [])
    }
}
