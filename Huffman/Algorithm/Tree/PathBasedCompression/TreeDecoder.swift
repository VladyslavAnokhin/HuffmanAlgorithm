//
//  TreeDecoder.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 21.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import Foundation

extension Huffman {
    static func decmopressTree(array: [Bool]) -> Tree {
        
        struct Info {
            let pathLenght: Int
            let path: [Bool]
            let value: Character
        }
        
        var mutArray = array
        var treeInfo = [Info]()
        
        while mutArray.isEmpty == false {
            let pathLenght = Int(awakeInt16(from: Array(mutArray[0..<16])))
            let path = Array(mutArray[16..<16+pathLenght])
            let value = Character(UnicodeScalar(Int(awakeInt16(from: Array(mutArray[16+pathLenght..<32+pathLenght]))))!)
            
            treeInfo.append(.init(pathLenght: pathLenght, path: path, value: value))
            mutArray = Array(mutArray.dropFirst(32+pathLenght))
        }
        
        func createSubTree(from array: [Info]) -> Tree.Node? {
            guard array.isEmpty == false else {
                return nil
            }
            
            if array.count == 1 {
                return Tree.Node(frequence: 0, value: array[0].value)
            }
            
            let leftSubInfo = array
                .filter { $0.path[0] == false }
                .map { Info(pathLenght: $0.pathLenght,
                            path: Array($0.path.dropFirst()),
                            value: $0.value) }
            
            let rightSubInfo = array
                .filter { $0.path[0] == true }
                .map { Info(pathLenght: $0.pathLenght,
                            path: Array($0.path.dropFirst()),
                            value: $0.value) }
            
            return Tree.Node(left: createSubTree(from: leftSubInfo),
                             right: createSubTree(from: rightSubInfo))
        }
        
        let root = createSubTree(from: treeInfo)
        
        return Tree(root: root)
    }
}
