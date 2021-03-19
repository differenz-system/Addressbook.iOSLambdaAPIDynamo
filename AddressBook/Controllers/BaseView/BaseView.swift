//
//  BaseView.swift
//  AddressBook
//
//  Created by Differenz System Pvt. Ltd.  on 03/16/2021.
//  Copyright ©  2021 Differenz System Pvt. Ltd. All rights reserved.
//

import UIKit

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Instance methods
    
    /**
     This method is used to set navigation bar left item with string.
        - Parameters:
            - title: Title of the item
            - action: Action of the button item
     */
    
    func setLeftNavigationItem(with title: String, action: Selector) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
    }
    
    /**
     This method is used to set navigation bar left item with image.
        - Parameters:
            - image: Image of the item
            - action: Action of the button item
     */
    
    func setLeftNavigationItem(withImage image: UIImage?, action: Selector) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "title", style: .plain, target: self, action: action)
    }
    
    /**
     This method is used to set navigation bar right item with string.
        - Parameters:
            - title: Title of the item
            - action: Action of the button item
     */
    
    func setRightNavigationItem(with title: String, action: Selector) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
