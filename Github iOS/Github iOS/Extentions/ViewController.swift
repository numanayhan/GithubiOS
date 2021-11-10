//
//  ViewController.swift
//  Github iOS
//
//  Created by Numan Ayhan on 2.11.2021.
//

import Foundation
import UIKit
extension UIViewController{
    
    func add(_ child:UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
       
    }
    func remove(){
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
