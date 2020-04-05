//
//  ViewCell.swift
//  Yam
//
//  Created by Илья Шевчук on 30.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit


class ViewCell: UITableViewCell {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Messenge: UILabel!
    @IBOutlet weak var PhotoUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
