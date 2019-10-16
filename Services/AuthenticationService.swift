//
//  AuthenticationService.swift
//  VKNewsFeed
//
//  Created by Veaceslav Chirita on 10/16/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthenticationService: NSObject {
    
    private let appID = "7172257"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSdk.initialize")
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("authorized")
                delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("initilized")
                VKSdk.authorize(scope)
            } else {
                print("auth problem, state \(state), error \(String(describing:error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
}

extension AuthenticationService: VKSdkDelegate, VKSdkUIDelegate {
    //MARK: VKSDKDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    //MARK: VKSDKUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
