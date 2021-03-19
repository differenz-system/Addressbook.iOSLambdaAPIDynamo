//
//  ListCell.swift
//  AddressBook
//
//  Created by Differenz System Pvt. Ltd.  on 03/16/2021.
//  Copyright ©  2021 Differenz System Pvt. Ltd. . All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = Utilities.isDeviceiPad() ? 10 : 5
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.init(red: 203/255, green: 203/255, blue: 203/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
