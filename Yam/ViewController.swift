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
    @IBOutlet weak var LoginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginView.layer.cornerRadius = 20
        LoginView.layer.masksToBounds = true
    }
}

extension ViewController  :ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

