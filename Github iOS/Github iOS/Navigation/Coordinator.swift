//
//  Coordinator.swift
//  Github iOS
//
//  Created by Numan Ayhan on 27.10.2021.
//

import Foundation
import UIKit

enum Event {
    case launch
    case trail
}
protocol Coordinator {
    var navigation:UINavigationController? {get set}
    var children: [Coordinator]? {get set}
    func eventOccured(with type:Event)
    func start()
}
protocol Coordinating {
    var coordinator:Coordinator? {get set}
}
