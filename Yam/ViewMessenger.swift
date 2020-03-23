//
//  ViewMessenger.swift
//  Yam
//
//  Created by Илья Шевчук on 23.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit


var messenger: [String] = ["user1","user2"]

class ViewMessenger: UIViewController {

   let idCell = "MailCell"
    @IBOutlet weak var TableMessenge: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableMessenge.dataSource = self
        TableMessenge.delegate = self
     
    
    }


}
extension ViewMessenger:UITableViewDataSource, UITableViewDelegate{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messenger.count // to do user count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = TableMessenge.dequeueReusableCell(withIdentifier: idCell)
        cell?.textLabel?.text = messenger [indexPath.row]
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: idCell)
        }
//        test strings
        cell!.textLabel?.text = "Username"
        cell!.detailTextLabel?.text = "Messenge"
        cell!.imageView?.image = #imageLiteral(resourceName: "logo")
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
