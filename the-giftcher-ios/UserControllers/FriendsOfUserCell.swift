//
//  FriendsOfUserCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 11/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
internal protocol FriendsOfUserCellDelegate {
}

class FriendsOfUserCell: UITableViewCell {
    
    static let identifier = "FriendsCellIdentifier"
    var delegate: FriendsOfUserCellDelegate?
    var cleanBirthday: String?
    var friend: UserFriendModel?{
        didSet { renderUI() }
    }
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendBirthday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func renderUI() {
        let name = friend?.name ?? ""
        let lastName = friend?.lastName ?? ""
        let fullName = "\(name) \(lastName)"
        
        friendName.text = fullName
        
        dateConverter()
        friendBirthday.text = cleanBirthday
        
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.borderWidth = 0.5
        
        if let avatar = friend?.imagePath {
            friendImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            friendImage.image = UIImage(named: "placeholder")
        }
    }
    
    func dateConverter() {
        let birthday = friend?.birthday ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: birthday) {
            print(dateFormatterPrint.string(from: date))
            cleanBirthday = dateFormatterPrint.string(from: date)
        }
    }
}

