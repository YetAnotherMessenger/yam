//
//  ChatView.swift
//  Yam
//
//  Created by Илья Шевчук on 24.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

struct ChatMessenge {
    let text : String
    let isIncoming : Bool
    let date : Date
}

extension Date {
    static func dateFromCustomString(customString : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString ) ?? Date()
    }
}

class ChatView: UIViewController {
    
    
    let CellID = "CellChatMe"
    
    @IBOutlet weak var TableViewChat: UITableView!
    @IBOutlet weak var MessengeField: UITextView!
    @IBOutlet weak var SendButton: UIButton!
    @IBAction func Send (_ sender: Any) {
    }
    
    var ChatMessenges = [
    [
        ChatMessenge(text:"Hello! ", isIncoming: true, date: Date.dateFromCustomString(customString: "10/02/2020")),
        ChatMessenge(text:"Hello! How are you ", isIncoming: true, date: Date.dateFromCustomString(customString: "10/02/2020")),
    ],
    [
        ChatMessenge(text:"I am writing to you from the new YAM messenger! Be sure to try available only for iOS! ", isIncoming: true, date: Date()),
        ChatMessenge(text:"Hello! things are good, I will definitely try! Thank! ", isIncoming: false, date: Date()),
        ChatMessenge(text:"Do not thank me ", isIncoming: true, date: Date()),
    ],
    [
        ChatMessenge(text: "I like this app! ", isIncoming: false, date: Date())
    ],
    
    ]
    
    override func viewDidLoad() {
        navigationItem.title = "Chat"
        TableViewChat.register(ChatViewCell.self, forCellReuseIdentifier: CellID)
        TableViewChat.separatorStyle = .none
        TableViewChat.backgroundColor = UIColor (white: 0.95, alpha: 1)
        TableViewChat.dataSource = self
        TableViewChat.delegate = self
        super.viewDidLoad()
    }
}
    
    

extension ChatView : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatMessenges[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChatMessenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewChat.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ChatViewCell
        
//        let chatMessenge = chatMessenges[indexPath.row]
        
        let chatMesseng = ChatMessenges[indexPath.section][indexPath.row]
        cell.chatMesseng = chatMesseng
        
        return cell
    }
    
    
    class DateHeaderLabel: UILabel{
        override var intrinsicContentSize: CGSize{
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = ChatMessenges[section].first {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            
            label.backgroundColor = .yellow
            label.text = "Some Date"
            label.textColor = .white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 15)
            let containerView = UIView()
            label.text = dateString
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
          return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
