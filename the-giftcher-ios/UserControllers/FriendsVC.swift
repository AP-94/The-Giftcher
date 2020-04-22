//
//  FriendsVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class FriendsVC: BaseVC {

    @IBOutlet weak var friendSearch: UITextField!
    @IBOutlet weak var friendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Friends"
    }
    
    @IBAction func friendsearchSubmit(_ sender: UIButton) {
    }
}
