//
//  FriendDetailVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class FriendDetailVC: UIViewController {

    @IBOutlet weak var friendProfilePic: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var wishTabs: UISegmentedControl!
    @IBOutlet weak var friendWishesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
