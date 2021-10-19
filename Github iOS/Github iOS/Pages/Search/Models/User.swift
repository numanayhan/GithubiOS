//
//  User.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
struct User:  Encodable, Decodable{
    var login: String?
    var avatar_url: String?
    var active:Bool?
}
