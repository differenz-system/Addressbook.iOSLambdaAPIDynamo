//
//  APIManager.swift
//  Addressbook

//  Created by mac on 03/16/2021.
//  Copyright ©  2021 Differenz System Pvt. Ltd. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire


class APIManager: NSObject {
 
    
    // MARK: - Check for internet connection
    
    /**
     This method is used to check internet connectivity.
     - Returns: Return boolean value to indicate device is connected with internet or not
     */
    
    
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    /**
     This method is used to make Alamofire request with or without parameters.
     - Parameters:
     - url: URL of request
     - method: HTTPMethod of request
     - parameter: Parameter of request
     - success: Success closure of method
     - response: Response object of request
     - failure: Failure closure of method
     - error: Failure error
     - connectionFailed: Network connection faild closure of method
     - error: Network error
     */
    
    class func makeRequest(with url: String, method: HTTPMethod, parameter: [String:Any]?, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void) {
        
        if(isConnectedToNetwork()) {
            print(method.rawValue, url)
            if let param = parameter, let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) {
                print(String(data: data, encoding: .utf8) ?? "Nil Param")
            }
           // let headers: [String:String] = [:]
            let headers : HTTPHeaders = [:]
            AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                
                switch (response.result) {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
                        print("Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
                    }
                    success(value)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                    failure(Constant.serverAPI.errorMessages.kCommanErrorMessage)
                }
            }
        }
        else {
            connectionFailed(Constant.serverAPI.errorMessages.kNoInternetConnectionMessage)
        }
    }
    
    
    

}
