//
//  AddFriendsTBCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 14/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol AddFriendsTBCellDelegate {
}

class AddFriendsTBCell: UITableViewCell {
    
    var delegate: AddFriendsTBCellDelegate?
    var cleanBirthday: String?
    var user: UserModel?{
        didSet { renderUI() }
    }
    
    //Outlets
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendUsername: UILabel!
    @IBOutlet weak var friendFullName: UILabel!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var containerView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func renderUI() {
        let name = user?.name ?? ""
        let lastName = user?.lastName ?? ""
           let fullName = "\(name) \(lastName)"
           
           friendFullName.text = fullName
           
           dateConverter()
           friendBirthday.text = cleanBirthday
           friendUsername.text = user?.username!
        
           
           containerView.layer.borderColor = UIColor.red.cgColor
           containerView.layer.borderWidth = 0.5
           
        if let avatar = user?.imagePath {
               friendImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
           } else {
               friendImage.image = UIImage(named: "placeholder")
           }
       }
       
       func dateConverter() {
        let birthday = user?.birthday ?? ""
           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "yyyy-MM-dd"

           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = "MMM dd,yyyy"

           if let date = dateFormatterGet.date(from: birthday) {
               cleanBirthday = dateFormatterPrint.string(from: date)
           }
       }

}
