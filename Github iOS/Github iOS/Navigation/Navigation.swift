//
//  Navigation.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation 
import UIKit
public class Navigation: UINavigationController {
    var isDark = false {
        didSet {
            
            setNeedsStatusBarAppearanceUpdate()
            
        }
    }
    var isHide = true {
        didSet {
            self.setNavigationBarHidden(isHide, animated: false)
            self.isNavigationBarHidden = isHide
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.backgroundColor  = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    
}
