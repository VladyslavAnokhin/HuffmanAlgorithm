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
        
        func compress(text: String) -> Data {
            let writer = BitWriter()
            
            text.forEach {
                guard let path = codesTables[$0] else { fatalError() }
                path.forEach(writer.writeBit)
            }
            
            writer.flush()
            return writer.data as Data
        }
    }
}
