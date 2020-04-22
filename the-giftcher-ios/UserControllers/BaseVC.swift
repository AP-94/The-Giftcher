//
//  BaseVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationModifier()

    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 217.0/255.0, green: 48.0/255.0, blue: 69.0/255.0, alpha: 1)
    }
}
