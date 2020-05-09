//
//  MainTabBarController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 18/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    @IBInspectable var defaultIndex: Int = 0

    override func viewDidLoad() {
        delegate = self
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 1.0, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
