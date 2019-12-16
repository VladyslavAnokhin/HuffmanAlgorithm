//
//  AppDelegate.swift
//  Huffman
//
//  Created by Vladyslav Anokhin on 02.10.2019.
//  Copyright © 2019 Vladyslav Anokhin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let data = try! Data(contentsOf: URL(string: "https://raw.githubusercontent.com/wess/iotr/master/lotr.txt")!)
        let text = String(data: data, encoding: .utf8)!
        
        print(Date())
        let result = Huffman.compress(string: text)
        print(Date())
        
        print(Date())
        let decompressed = Huffman.decompress(data: result)
        print(Date())
        
        print(data)
        print(result)
        print(decompressed == text)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}
