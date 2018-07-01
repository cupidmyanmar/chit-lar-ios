//
//  APIClient.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit
import Alamofire

class APIClient: NSObject {
    
    static let shared = APIClient()
    
    func requestGETURL(_ strURL: String, headers: [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            //debugPrint(response)
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                success(utf8Text)
            }
            
            if response.result.isSuccess {
                if let json = response.result.value {
                    success(json)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params: [String : AnyObject]?, headers: [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            
            //debugPrint(responseObject)
            
            if response.result.isSuccess {
                if let json = response.result.value {
                    success(json)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
}
