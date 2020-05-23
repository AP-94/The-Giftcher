//
//  FriendRequestTBCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 14/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
internal protocol FriendRequestTBCellDelegate {
}

class FriendRequestTBCell: UITableViewCell {
    
    var delegate: FriendRequestTBCellDelegate?
    var cleanBirthday: String?
    var friend: UserModel?{
        didSet { renderUI() }
    }
    
    //Outlets
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendUsername: UILabel!
    @IBOutlet weak var friendFullname: UILabel!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func renderUI() {
        let name = friend?.name ?? ""
        let lastName = friend?.lastName ?? ""
        let fullName = "\(name) \(lastName)"
        
        friendFullname.text = fullName
        friendUsername.text = friend?.username!
        
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
            cleanBirthday = dateFormatterPrint.string(from: date)
        }
    }
    
    
}
