//
//  ContactsView.swift
//  Yam
//
//  Created by Илья Шевчук on 05.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

var contact: [String] = [" "]

class ContactsView: UIViewController {

    let idCell = "ContactCell"
    
    
    @IBOutlet weak var ContactsView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactsView.dataSource = self
        ContactsView.delegate = self
    }

  

}
extension ContactsView:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil{
            cell = UITableViewCell (style: .default, reuseIdentifier: idCell)
        }
        

        return cell!
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
   


    

