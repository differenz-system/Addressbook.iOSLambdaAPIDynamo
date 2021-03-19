//
//  UserModel.swift
//  AddressBook
//
//  Created by mac on 03/16/2021.
//  Copyright © 2021 Differenz System. All rights reserved.
//

import UIKit
import SVProgressHUD
import Foundation
import SystemConfiguration
import Alamofire

let kAddressId      = "addressId"
let kName           = "name"
let kEmail          = "email"
let kContactNo      = "contactNo"
let kUserId         = "userId"
let kIsactive       = "isactive"
let kActive         = "active"
let kId             = "Id"
let kItems          = "Items"
let kTableName      = "tableName"
let kCount          = "Count"
let kScannedCount   = "ScannedCount"
//Header Key
let kHeader         = "x-api-key"


class UserModel:NSObject, NSCoding {
    var addressId:String
    var name:String
    var email:String
    var contactNo:String
    var userId:String
    var isActive:String
    var id:String
    var active:String
    
    init?(dictionary: [String:Any]) {
        self.addressId = dictionary[kAddressId] as? String ?? ""
        self.name = dictionary[kName] as? String ?? ""
        self.email = dictionary[kEmail] as? String ?? ""
        self.contactNo = dictionary[kContactNo] as? String ?? ""
        self.userId = dictionary[kUserId] as? String ?? "0"
        self.isActive = dictionary[kIsactive] as? String ?? "0"
        self.id = dictionary[kId] as? String ?? "0"
        self.active = dictionary[kActive] as? String ?? "0"
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(addressId, forKey: kAddressId)
        aCoder.encode(name,forKey: kName)
        aCoder.encode(email, forKey: kEmail)
        aCoder.encode(contactNo, forKey:kContactNo)
        aCoder.encode(userId, forKey:kUserId)
        aCoder.encode(isActive, forKey:kIsactive)
        aCoder.encode(id, forKey:kId)
        aCoder.encode(active, forKey:kActive)
    }
    required init?(coder aDecoder: NSCoder) {
        addressId =  aDecoder.decodeObject(forKey:kAddressId) as? String ?? ""
        name = aDecoder.decodeObject(forKey:kName) as? String ?? ""
        email = aDecoder.decodeObject(forKey:kEmail) as? String ?? ""
        contactNo = aDecoder.decodeObject(forKey:kContactNo) as? String ?? ""
        userId = aDecoder.decodeObject(forKey:kUserId) as? String ?? "0"
        isActive = aDecoder.decodeObject(forKey:kIsactive) as? String ?? ""
        id = aDecoder.decodeObject(forKey:kId) as? String ?? ""
        active = aDecoder.decodeObject(forKey:kActive) as? String ?? "0"
    }
    
    // MARK: - API call
    class func saveUserDetail(withAddressId userAddressId: String,
                              userName: String,
                              userEmail:String,
                              userContactNo:String,
                              userIsActive:String,
                              success withResponse: @escaping ([String:Any]) -> Void,
                              failure: @escaping (_ error: String) -> Void) {
        let param: [String:Any] = [
            kAddressId: userAddressId,
            kName: userName,
            kEmail:userEmail,
            kContactNo:userContactNo,
            kUserId:"1",
            kIsactive:userIsActive
        ]
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: Constant.serverAPI.URL.save, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            withResponse(dict)
            
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            
            failure(error)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError)
        })
    }
    
    class func updateUserDetail(withAddressId userAddressId: String,
                                userName: String,
                                userEmail:String,
                                userContactNo:String,
                                userIsActive:String,
                                success withResponse: @escaping ([String:Any]) -> Void,
                                failure: @escaping (_ error: String) -> Void) {
        let param: [String:Any] = [
            kAddressId: userAddressId,
            kName: userName,
            kEmail:userEmail,
            kContactNo:userContactNo,
            kIsactive:userIsActive
        ]
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: Constant.serverAPI.URL.save, method: .put, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            withResponse(dict)
            
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            
            failure(error)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError)
        })
    }
    
    
    class func displayAdressList(withtableName tableNameData: String,
                                 success withResponse: @escaping ([UserModel],_ count:Int ,_ scanneCount:Int) -> Void,
                                 failure: @escaping (_ error: String) -> Void) {
        let param: [String:Any] = [
            kTableName:tableNameData,
            kUserId:"1"
        ]
        SVProgressHUD.show()
        APIManager.makeRequest(with: Constant.serverAPI.URL.save, method: .get, parameter: param, success: {(response) in
            print(response)
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            print(dict)
            let count:Int = dict[kCount] as! Int
            let scannedScount:Int = dict[kScannedCount] as! Int
            let dataDict = dict[kItems] as? [[String:Any]] ?? [[:]]
            
            var addressBookData = [UserModel]()
            for  i in dataDict {
                if let homeObj = UserModel(dictionary: i) {
                    addressBookData.append(homeObj)
                }
            }
            withResponse(addressBookData,count,scannedScount)
            
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            
            failure(error)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError)
        })
    }
    
    class func deleteUser(withAddressId userAddressId: String,
                          success withResponse: @escaping ([String:Any]) -> Void,
                          failure: @escaping (_ error: String) -> Void) {
        let param: [String:Any] = [
            kAddressId: userAddressId
        ]
        SVProgressHUD.show()
        APIManager.makeRequest(with: Constant.serverAPI.URL.save, method: .delete, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            withResponse(response as! [String : Any])
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError)
        })
    }
}
