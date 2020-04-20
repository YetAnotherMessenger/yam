//
//  ViewController.swift
//  Yam
//
//  Created by Антон Уханов on 29.02.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    let userData  = User()
    @IBAction func buttonClick(_ sender: UIButton) {
        let menuStoryboard = UIStoryboard(name: "Menu", bundle: nil)

        let vkMessenger = VK()
        vkMessenger.signInWebAuth( success: {
            vkMessenger.getContacts( success: { contacts in
                for contact in contacts {
                    self.userData.friendList.append(contact)
                }
                self.userData.messengersList.append(vkMessenger)
                
                let vc = menuStoryboard.instantiateViewController(identifier: "BarController") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen

                let nc = vc.viewControllers!.filter({ (v) -> Bool in
                        return (v is UINavigationController)
                })[0] as! UINavigationController
                let contactsView = vc.viewControllers!.filter({ (v) -> Bool in
                        return (v is ContactsView)
                })[0] as! ContactsView
                let chatView = nc.viewControllers.filter({ (v) -> Bool in
                        return (v is ViewMessenger)
                })[0] as! ViewMessenger
                
                contactsView.userData = self.userData
                chatView.userData = self.userData
                self.present(vc, animated: true, completion: nil)
                
            }) { error in
                debugPrint(error)
            }
        }, failure: { error in
            debugPrint(error)
        }, contextProvider: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController : ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}
