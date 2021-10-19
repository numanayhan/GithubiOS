//
//  UserDetailMVVM.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class UserDetailMVVM {
    var request : URLRequest!
    var urlRequest = Config.shared.baseURL
     
    func searchUsers( _ text:String,completion : @escaping (User) ->Void ){
        var baseUrl = Config.shared.baseURL
            
        if !text.isEmpty {
            baseUrl  = baseUrl + "/" + text
            
        }
        request = URLRequest(url:URL(string:  baseUrl)!,timeoutInterval: .infinity)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        ServiceManager.shared.genericRequest(request: request, expecting: User.self) { results in
            
            switch results {
            case .success(let data):
                completion(data!)
            case .failure( let err ):
               print("er",err)
            }
        }
                         
    }
}
