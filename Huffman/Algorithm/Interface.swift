//
//  Interface.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

enum Huffman {
    static func compress(string: String) -> (compressed: Data, decompres: () -> String ) {

        let nodes = analize(string: string)
                    .map { Tree.Node(frequence: $0.value, value: $0.key) }
        let tree = Tree(array: nodes)
        
        print(tree.description)
        
        let codesTable = convertTreeToCodesTable(tree: tree)
        let compressor = Compressor(codesTables: codesTable)
        let decompressor = Decompressor(tree: tree)
        
        let compressed = compressor.compress(text: string)
        
        return (compressed: compressed,
                decompres: {
                    decompressor.decompress(data: compressed)
        })
    }
}
