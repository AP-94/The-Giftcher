//
//  FriendCell.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 23/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

protocol FriendCellDelegate {
    func callPressed(name: String)
}

class FriendCell: UITableViewCell {
    @IBOutlet weak var friendProfilePic: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var delegate: FriendCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
