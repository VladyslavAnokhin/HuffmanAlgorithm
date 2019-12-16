//
//  BitReader.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 23.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    class BitReader {
        
        func readBit(from int8: UInt8) -> [Bool] {
            let bitsOfAbyte = 8
            var bitsArray = [Bool](repeating: false, count: bitsOfAbyte)
            for (index, _) in bitsArray.enumerated() {
                // Bitwise shift to clear unrelevant bits
                let bitVal: UInt8 = 1 << UInt8(bitsOfAbyte - 1 - index)
                let check = int8 & bitVal
                bitsArray[index] = check != 0
            }
            
            return bitsArray
        }
        
        func readBit(from int16: UInt16) -> [Bool] {
            let bitsOfAbyte = 16
            var bitsArray = [Bool](repeating: false, count: bitsOfAbyte)
            for (index, _) in bitsArray.enumerated() {
                // Bitwise shift to clear unrelevant bits
                let bitVal: UInt16 = 1 << UInt16(bitsOfAbyte - 1 - index)
                let check = int16 & bitVal
                bitsArray[index] = check != 0
            }
            
            return bitsArray
        }
        
        func readBit(from data: Data) -> [Bool] {
            return data.map(readBit)
                .reduce(into: []) { result, array in
                    result.append(contentsOf: array)
            }
        }
    }
    
    static func awakeInt16(from byte: [Bool]) -> UInt16 {
        guard byte.count == 16 else { fatalError() }
        return UInt16(awakeInt(from: byte))
    }
    
    static func awakeInt(from byte: [Bool]) -> Int {
        let str = byte.map {
            $0 == true ? "1" : "0"
        }.joined()
        
        guard let int = Int(str, radix: 2) else {
            fatalError()
        }
        
        return int
    }
}
