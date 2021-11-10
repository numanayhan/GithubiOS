//
//  AppRoot.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
import UIKit

class AppRoot {
    private let window : UIWindow?
    init(window: UIWindow ) {
        self.window = window
    }
    func startApp() {
        
        let root = Navigation(rootViewController: Launch())
        root.isDark = true
        root.isHide = false
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
    func nameList(){
        let root = Navigation(rootViewController: NameLists())
        root.isDark = true
        root.isHide = false
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
    func coridanor(_ view:UIViewController){
        
        let root = Navigation(rootViewController: view)
        root.isDark = true
        root.isHide = false
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
}
