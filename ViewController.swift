//
//  ViewController.swift
//  Yam
//
//  Created by Антон Уханов on 29.02.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBAction func buttonClick(_ sender: UIButton) {
        if sender.titleLabel?.text == "Enter" {
            let storyboard2 = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard2.instantiateViewController(identifier: "BarController") as UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }


}

