//
//  ViewController.swift
//  Yam
//
//  Created by Антон Уханов on 29.02.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LoginView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginView.layer.cornerRadius = 20
        LoginView.layer.masksToBounds = true
  
        
        //VerticalConstrain.constant = 100
        // Do any additional setup after loading the view.
        let testUser = User()
        print("name:", testUser.Name, testUser.ID)
        let testUser2 = Person()
        testUser2.Name = "kekich"
        print("name:", testUser2.Name, testUser2.ID)
    }


}

