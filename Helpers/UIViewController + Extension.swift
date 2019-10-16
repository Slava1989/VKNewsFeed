//
//  UIViewController + Extension.swift
//  VKNewsFeed
//
//  Created by Veaceslav Chirita on 10/16/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
    
}
