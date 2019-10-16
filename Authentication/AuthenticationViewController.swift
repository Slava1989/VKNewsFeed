//
//  AuthenticationViewController.swift
//  VKNewsFeed
//
//  Created by Veaceslav Chirita on 10/16/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    private var authService: AuthenticationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        authService = AuthenticationService()
        authService = AppDelegate.shared().authService
    }
    
    @IBAction func connectVKDidTap(_ sender: Any) {
        authService.wakeUpSession()
    }
}
