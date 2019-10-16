//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Veaceslav Chirita on 10/16/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
    var window: UIWindow?
    
    var authService: AuthenticationService!
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        self.authService = AuthenticationService()
        authService.delegate = self
        
        let authVC: AuthenticationViewController = AuthenticationViewController.loadFromStoryboard()
        
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC: FeedViewController = FeedViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
    
}

