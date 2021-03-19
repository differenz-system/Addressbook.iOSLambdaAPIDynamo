//
//  Utilities.swift
//  AddressBook
//
//  Created by Differenz System Pvt. Ltd.  on 03/16/2021.
//  Copyright ©  2021 Differenz System Pvt. Ltd. . All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    /**
     This method is used to check internet connectivity.
        - Returns: Return boolean value to indicate device is connected with internet or not
     */
    static func checkInternetConnection() -> Bool {
        if(APIManager.isConnectedToNetwork()) {
            return true
        }
        else {
            return false
        }
    }
    
    /**
     This method is used to know current device is iPad or not.
        - Returns: Return boolean value to indicate device is iPad or not
     */
    class func isDeviceiPad() -> Bool  {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /**
     This method is used to show alert.
        - Parameters:
            - msg: Message that needs to dispaly with alert
            - vc: Object of UIViewController from which you want to show alert
     */
    static func showAlert(msg : String , vc : UIViewController) {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true)
    }
}

