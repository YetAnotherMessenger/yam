//
//  ContactsView.swift
//  Yam
//
//  Created by Илья Шевчук on 05.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

class ContactsView: UIViewController {
    @IBOutlet weak var ContactsView: UITableView!
    
    var userData : User!
    let cellID = "ContactCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactsView.dataSource = self
        ContactsView.delegate = self
    }

  

}
extension ContactsView:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ContactCell
        
        cell.UserName.text = self.userData.friendList[indexPath.row].name

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
   


    

