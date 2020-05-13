//
//  FriendWishCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 13/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol FriendWishCellDelegate {
    
}

class FriendWishCell: UICollectionViewCell {
    
    var delegate: FriendWishCellDelegate?
    var selectable = false
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var wishContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func renderUI() {
            wishName.text = wish?.name
            
            wishContainer.layer.borderColor = UIColor.red.cgColor
            wishContainer.layer.borderWidth = 0.5
            
            if let avatar = wish?.imagePath {
                wishImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
            } else {
                wishImage.image = UIImage(named: "placeholder")
            }
        }
        
}
