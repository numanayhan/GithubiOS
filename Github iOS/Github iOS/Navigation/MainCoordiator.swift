//
//  MainCoordiator.swift
//  Github iOS
//
//  Created by Numan Ayhan on 27.10.2021.
//

import Foundation
import UIKit

class MainCoordiator: Coordinator {
    var children: [Coordinator]? = nil
    
    var navigation: UINavigationController?
    
    func eventOccured(with type: Event) {
        
        switch type {
        case .launch:
            var vc:UIViewController & Coordinating = Launch()
            vc.coordinator = self
            navigation?.setViewControllers([vc], animated: true)
        case .trail:
            var vc:UIViewController & Coordinating = Trail()
            vc.coordinator = self
            navigation?.pushViewController(vc, animated: true)
        
        }
    }
    
    func start() {
        var vc:UIViewController & Coordinating = Launch()
        vc.coordinator = self
        navigation?.setViewControllers([vc], animated: true)
    }
}
