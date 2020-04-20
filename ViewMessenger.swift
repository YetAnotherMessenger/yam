//
//  ViewMessenger.swift
//  Yam
//
//  Created by Илья Шевчук on 23.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit




class ViewMessenger: UIViewController {
    @IBOutlet weak var TableMessenge: UITableView!
    
    var userData : User!
    let cellID = "MailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableMessenge.dataSource = self
        self.TableMessenge.delegate = self
    }
}
extension ViewMessenger : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.friendList.count // to do user count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMessenge.dequeueReusableCell(withIdentifier: self.cellID) as! ViewCell
        cell.UserName.text = self.userData.friendList[indexPath.row].name
        //TODO: get last message from history
        cell.Messenge.text = "Last message"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
                _, indexPath in
                self.userData.friendList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return [deleteAction]
        }
}
