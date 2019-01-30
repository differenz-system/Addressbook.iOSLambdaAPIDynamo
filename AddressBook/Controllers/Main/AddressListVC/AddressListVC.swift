
//
//  AddressLustVC.swift
//  AddressBook
//
//  Created by MohiniPatel on 9/20/17.
//  Copyright © 2017 Differenz System. All rights reserved.
//

import UIKit
import CoreData
class AddressListVC: BaseView {
    
    //MARK: - IBoutlet
    @IBOutlet weak var tblAddress: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var arrAddressBookData = [UserModel]()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initialConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAddressBookListData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button action methods
    
    /**
     This method is used to handle logout button click.
        - Parameter sender: action button
     */
    @objc func logoutClick(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: Constant.UserDefaultsKey.IsLogin)
        self.appDelegate.setupRootView()
    }
    
    /**
     This method is used to handle add address button click.
        - Parameter sender: action button
     */
    @objc func addClick(_ sender: Any) {
        let addAddressVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdetinfier.AddAddressVC) as! AddAddressVC
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    //MARK: - Instance methods
    
    /**
     This method is used for initial configuration of Controller.
     */
    func initialConfig() {
        self.setUpNavigationBar()
        self.tblAddress.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        self.tblAddress.tableFooterView = UIView()
        self.tblAddress.estimatedRowHeight = 84
        self.tblAddress.rowHeight = UITableViewAutomaticDimension
        self.lblNoData.isHidden = true
        
    }
    
    /**
     This method is used to setup navigation bar.
     */
    
    func setUpNavigationBar() {
        self.title = "Address Book"
        self.navigationController?.navigationBar.tintColor = .white
        self.setLeftNavigationItem(with: "Logout", action: #selector(logoutClick(_:)))
        self.setRightNavigationItem(with: "Add", action: #selector(addClick(_:)))
    }
    
    /**
     This method is used to fetch data from Server.
     */

    func getAddressBookListData() {
        UserModel.displayAdressList(withtableName: "AddressBook", success: { (response, count, scannedCount) in
            self.arrAddressBookData = response
            self.tblAddress.reloadData()
        }) { (error) in
            print(error)
             Utilities.showAlert(msg: error, vc: self)
        }
    }
}

//MARK: - UITableview Delegate and DataSource methods
extension AddressListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.users.count
        return arrAddressBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        //Set up user data in cell
        cell.lblName.text = self.arrAddressBookData[indexPath.row].name
        cell.lblEmail.text = self.arrAddressBookData[indexPath.row].email
        cell.lblContactNo.text = self.arrAddressBookData[indexPath.row].contactNo
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let addAddressVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdetinfier.AddAddressVC) as! AddAddressVC
        addAddressVC.editUser = self.arrAddressBookData[indexPath.row]
        addAddressVC.editUserIndex = indexPath.row
        self.navigationController?.pushViewController(addAddressVC, animated: true)

    }
}
