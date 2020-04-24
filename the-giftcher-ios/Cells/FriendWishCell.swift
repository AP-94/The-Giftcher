//
//  FriendWishCell.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

protocol FriendWishCellDelegate {
    func callPressed(name: String)
}

class FriendWishCell: UICollectionViewCell {
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishName: UILabel!
    
    var delegate: FriendWishCellDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
    }
