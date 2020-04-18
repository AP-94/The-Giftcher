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
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }

}
