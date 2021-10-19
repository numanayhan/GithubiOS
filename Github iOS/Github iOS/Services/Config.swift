//
//  Config.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
class Config {
    
    static let shared: Config = {
        return Config()
    }()
    
    let  baseURL  =  "https://api.github.com/users"
    
}
