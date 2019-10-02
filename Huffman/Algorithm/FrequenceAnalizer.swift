//
//  FrequenceAnalizer.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    class FrequenceAnalizer {
        
        func analize(string: String) -> [Character: Int] {
            return string.reduce(into: [:]) { result, char in
                let frequance = result[char]
                result[char] = (frequance ?? 0) + 1
            }
        }
    }
}
