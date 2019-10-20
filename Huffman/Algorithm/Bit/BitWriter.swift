//
//  BitWriter.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 23.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    class BitWriter {
        var data = NSMutableData()
        var outByte: UInt8 = 0
        var outCount = 0
        
        func writeBit(bit: Bool) {
            if outCount == 8 {
                data.append(&outByte, length: 1)
                outCount = 0
            }
            outByte = (outByte << 1) | (bit ? 1 : 0)
            outCount += 1
        }
        
        func flush() {
            if outCount > 0 {
                if outCount < 8 {
                    let diff = UInt8(8 - outCount)
                    outByte <<= diff
                }
                data.append(&outByte, length: 1)
            }
        }
    }
}

