//
//  Compressor.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    class Compressor {
        
        let codesTables: [Character: [Bool]]
        
        init(codesTables: [Character: [Bool]]) {
            self.codesTables = codesTables
        }
        
        func compress(text: String) -> [Bool] {
            return text.reduce(into: [Bool]()) { (result, c) in
                guard let path = self.codesTables[c] else { fatalError() }
                result.append(contentsOf: path)
            }
        }
    }
}
