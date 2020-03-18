//
//  ViewController.swift
//  Yam
//
//  Created by Антон Уханов on 29.02.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import UIKit
import AuthenticationServices
import SafariServices

class ViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    @IBOutlet weak var LoginView: UIView!
    var webAuthSession: ASWebAuthenticationSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginView.layer.cornerRadius = 20
        LoginView.layer.masksToBounds = true
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    //no log pass authorization
    func VKAuth(context: ASWebAuthenticationPresentationContextProviding) {
        webAuthSession?.cancel()
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")!
        let queryItems = [URLQueryItem(name:"client_id", value: "7339825"),
                          URLQueryItem(name:"display", value: "mobile"),
                          URLQueryItem(name:"redirect_uri", value: "https://oauth.vk.com/"),
                          URLQueryItem(name:"response_type", value: "token"),
                          URLQueryItem(name:"state", value: "yam://"),
                          URLQueryItem(name:"scope", value: "friends"), //add messages
                          URLQueryItem(name:"v", value: "5.103")]
        urlComponents.queryItems = queryItems
        //print(urlComponents.url)
        let scheme = "https://oauth.vk.com/"
        self.webAuthSession = ASWebAuthenticationSession.init(url: urlComponents.url!, callbackURLScheme: scheme, completionHandler: { callback, error in
            guard error == nil, let success = callback else { return }
            let token = NSURLComponents(string: (callback!.absoluteString))?.queryItems?.filter({ $0.name == "access_token" }).first
                  print(token)
        })
        self.webAuthSession?.prefersEphemeralWebBrowserSession = true
        self.webAuthSession?.presentationContextProvider = context
        self.webAuthSession?.start()
    }

}

