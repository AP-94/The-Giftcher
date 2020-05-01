//
//  ProfileVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit


class ProfileVC: BaseVC {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBirthdayLabel: UILabel!
    @IBOutlet weak var wishSegment: UISegmentedControl!
    @IBOutlet weak var userWishCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Perfil"
        
        userProfileImage.layer.cornerRadius = 90
        userProfileImage.layer.borderWidth = 8
        userProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        
        userNameLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        userBirthdayLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        
        
    }
    
}
