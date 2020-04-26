//
//  ChatViewCell.swift
//  Yam
//
//  Created by Илья Шевчук on 24.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var MessengeTextLabel: UILabel!
    @IBOutlet weak var MessengeText: UILabel!
    
    let messengeLabel = UILabel()
    let bubblebackgroundView = UIView()
    
    var ledingConstraint : NSLayoutConstraint!
    var trialingConstraint :NSLayoutConstraint!
    
    var chatMesseng : ChatMessenge! {
        didSet {
            bubblebackgroundView.backgroundColor = chatMesseng.isIncoming ? .gray : .blue
            messengeLabel.textColor = chatMesseng.isIncoming ? .black : .white
            messengeLabel.text = chatMesseng.text
            
            if chatMesseng.isIncoming{
                ledingConstraint.isActive = true
                trialingConstraint.isActive = false
            } else{
                ledingConstraint.isActive = false
                trialingConstraint.isActive = true
            }

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        
        backgroundColor = .clear
        
        bubblebackgroundView.layer.cornerRadius = 16
        bubblebackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubblebackgroundView)
        
        addSubview(messengeLabel)

        messengeLabel.numberOfLines = 0
        
        messengeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [messengeLabel.topAnchor.constraint(equalTo:topAnchor, constant: 32),
        messengeLabel.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -16),
        messengeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
        bubblebackgroundView.topAnchor.constraint(equalTo: messengeLabel.topAnchor, constant:  -16),
        bubblebackgroundView.leadingAnchor.constraint(equalTo: messengeLabel.leadingAnchor, constant:  -16),
        bubblebackgroundView.bottomAnchor.constraint(equalTo: messengeLabel.bottomAnchor, constant:  16),
        bubblebackgroundView.widthAnchor.constraint(equalTo: messengeLabel.widthAnchor, constant:  16),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        ledingConstraint = messengeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        ledingConstraint.isActive = false
        
        trialingConstraint = messengeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trialingConstraint.isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
