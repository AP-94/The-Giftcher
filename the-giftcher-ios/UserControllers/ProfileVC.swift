//
//  ProfileVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit


class ProfileVC: BaseVC {
    
    var user = Session.current.userModel
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBirthdayLabel: UILabel!
    @IBOutlet weak var wishSegment: UISegmentedControl!
    @IBOutlet weak var userWishCollectionView: UICollectionView!
    @IBOutlet weak var profileImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Perfil"
        
        userProfileImage.layer.cornerRadius = 90
        userProfileImage.layer.borderWidth = 8
        userProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        
        userNameLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        userBirthdayLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        callInfo()
        setAvatar()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callInfo()
        setAvatar()
    }
    
    func callInfo(){
        let name = user?.name ?? ""
        let lastName = user?.lastName ?? ""
        let userName = user?.username ?? ""
        
        userNameLabel.text = "\(name) \(lastName) (\(userName))"
        userBirthdayLabel.text = user?.birthday ?? ""
    }
    
    func setAvatar() {
        if let avatar = user?.imagePath {
            userProfileImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            if user?.imagePath == "" || user?.imagePath == nil {
                userProfileImage.layer.borderWidth = 1
                userProfileImage.layer.borderColor = UIColor.gray.cgColor
                profileImageLabel.isHidden = false
                var nameLabelText = ""
                let name = user?.name
                let lastName = user?.lastName
                
                if !name!.isEmpty && !lastName!.isEmpty {
                    nameLabelText = (name?.prefix(1).uppercased())! + (lastName?.prefix(1).uppercased())!
                } else {
                    nameLabelText = (name?.prefix(1).uppercased())!
                }
                
                profileImageLabel.text = nameLabelText
            }
        }
    }
}
