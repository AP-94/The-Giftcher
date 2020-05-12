//
//  FriendDetailVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class FriendDetailVC: ViewController, NVActivityIndicatorViewable {

    
    var friend: UserFriendModel?
    var dataMapper = DataMapper()
    var friendWishes: [WishModel?] = []
    var cleanBirthday: String?
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    
    
    //Outlets
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var wishBanner: UILabel!
    @IBOutlet weak var friendWishesCollectionView: UICollectionView!
    @IBOutlet weak var wishesCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModifiers()
        loadData()
    }
    
    func viewModifiers() {
        friendName.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        friendBirthday.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        
        dateConverter()
        friendBirthday.text = cleanBirthday
        
        let name = friend?.name ?? ""
        let lastName = friend?.lastName ?? ""
        let fullName = "\(name) \(lastName)"
        
        friendName.text = fullName
        userProfileImage.layer.cornerRadius = 90
        userProfileImage.layer.borderWidth = 5
        userProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
    
    }
    
    func dateConverter() {
        let birthday = friend?.birthday ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: birthday) {
            cleanBirthday = dateFormatterPrint.string(from: date)
        }
    }
    
    func loadData() {
        print("Do Get All wishes of friend request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        let userId = friend?.friendId!
        dataMapper.getFriendWishesRequest(userId: userId!) {
            success, result, error in
            if let result = result as? [WishModel] {
                self.friendWishes.removeAll()
                self.friendWishes = result
                self.wishesCount.text = String(self.friendWishes.count)
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }


}
