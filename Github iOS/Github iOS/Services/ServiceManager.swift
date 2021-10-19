//
//  ServiceManager.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class ServiceManager {
    static let shared: ServiceManager = {
        return ServiceManager()
    }()
    
    typealias handler = ((Result<Data, CustomError>) -> Void)
    var requestAF: Alamofire.Request?
    
    func  genericRequest<T:Decodable>( request : URLRequest ,expecting:T.Type , completion: @escaping ((Result<T?,CustomError>) ->  Void  ))
    {
        AF.request(request).response { response  in
            
            guard let statusCode = response.response?.statusCode else { return }
             
            if statusCode == 200 {
                if response.data != nil {
                  do {
                      guard let jsonResp =  try? response.result.get() else { return }
                     
                      let result = try JSONDecoder().decode(T.self, from: jsonResp)
//                    print("result",result)
                        completion(.success(result))
                  } catch let jsonError as NSError {
                    completion(.failure(CustomError.invalidData))
                  } catch (let err){
                      print(err.localizedDescription)
                  }
                   
                }
            }else if statusCode == 401 {
                completion(.failure(CustomError.authorize))
                 
            }else if statusCode > 500{
                completion(.failure(CustomError.unavailableServer))
                
            } else {
                completion(.failure(CustomError.genericError))
                
            }
            
        }
        
    }
   
}
