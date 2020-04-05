//
//  ContactCell.swift
//  Yam
//
//  Created by Илья Шевчук on 05.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

 
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
