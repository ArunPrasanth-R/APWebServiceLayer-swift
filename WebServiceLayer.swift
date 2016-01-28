//
//  WebServiceLayer.swift
//  StayFit
//
//  Created by ArunPrasanth R on 28/11/15.
//  Copyright © 2015 ArunPrasanth R. All rights reserved.
//

import UIKit
import Alamofire

//Providing typealias is very handy for closures in swift. This will increase readability in method definitions with closures

typealias WebserviceHandler = (json: AnyObject? , error : NSError?)  -> Void

class WebServiceLayer: NSObject {
    
    func callWebService(url: String, parameters: [String : AnyObject]?,headers: [String: String]?,method:String, handler:WebserviceHandler) {
        
            let token = "Token " as NSString
            let accesstoken = SFProfileUtility .sharedInstance.access_token as String
            let authToken =  (token as String)+accesstoken
            // set header fields
            let headers = ["Authorization": authToken,"Accept": "application/json","Content-Type": "application/json"]
            
            if method == "GET" {
                Alamofire.request(.GET, url, headers:headers, parameters: parameters)
                    .responseJSON { response in
                        print(response.request)
                        //print(response.request)  // original URL request
                        print(response.response) // URL response
                        //print(response.data)     // server data
                        print(response.result)   // result of response serialization
                        
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            handler(json: JSON, error: nil)
                            
                        } else {
                            handler(json: nil, error: NSError(domain:"Error", code: 0, userInfo: nil))
                        }
                }
                
            } else if method == "POST" {
                
                Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers) .responseJSON { response in
 
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        handler(json: JSON, error: nil)
                        
                    } else {
                        handler(json: nil, error: NSError(domain:"Error", code: 0, userInfo: nil))
                    }
                }
                
            } else if method == "PUT" {
                
                Alamofire.request(.PUT, url, parameters: parameters, encoding: .JSON, headers: headers) .responseJSON { response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        handler(json: JSON, error: nil)
                        
                    } else {
                        handler(json: nil, error: NSError(domain:"Error", code: 0, userInfo: nil))
                    }
                }
            } else if method == "DELETE" {
                
                Alamofire.request(.DELETE, url, parameters: parameters, encoding: .JSON, headers: headers) .responseJSON { response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        handler(json: JSON, error: nil)
                        
                    } else {
                        handler(json: nil, error: NSError(domain:"Error", code: 0, userInfo: nil))
                    }
                }
            }
    }
}
