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
        
        var treeInfo = [Info]()
        
        var i = 0
        while i < array.count {
            
            let startPathLenght = i
            let endPathLenght = i + 16
            let pathLenght = Int(awakeInt16(from: Array(array[startPathLenght..<endPathLenght])))
            
            let startPath = endPathLenght
            let endPath = startPath + pathLenght
            let path = Array(array[startPath..<endPath])
            
            let valueStart = endPath
            let endValue = valueStart + 16
            let value = Character(UnicodeScalar(Int(awakeInt16(from: Array(array[valueStart..<endValue]))))!)
            
            treeInfo.append(.init(pathLenght: pathLenght, path: path, value: value))
            i = endValue
        }
        
        func createSubTree(from array: [Info]) -> Tree.Node? {
            if array.count == 1 {
                return Tree.Node(frequence: 0, type: .leaf(value: array[0].value))
            }
            
            func getSubTree(isRight right: Bool) -> [Info] {
                return array
                .filter { $0.path[0] == right }
                .map { Info(pathLenght: $0.pathLenght,
                            path: Array($0.path.dropFirst()),
                            value: $0.value) }
            }
            
            return Tree.Node(frequence: 0,
                             type: .node(left: createSubTree(from: getSubTree(isRight: false))!,
                                         right: createSubTree(from: getSubTree(isRight: true))!))
        }
        
        let root = createSubTree(from: treeInfo)
        
        return Tree(root: root)
    }
}
