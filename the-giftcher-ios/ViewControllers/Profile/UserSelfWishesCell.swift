//
//  UserSelfWishesCell.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 10/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol UserSelfWishesCellDelegate {
    
}

class UserSelfWishesCell: UICollectionViewCell {
    
//    static let identifier = "UserSelfWishCellIdentifier"
    var delegate: UserSelfWishesCellDelegate?
    var selectable = false
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    var reservedWish: ReservedWishesModel?{
        didSet { renderUI() }
    }
    
    var reservedFriend: ReservedFriendModel?{
        didSet { renderUI() }
    }
    
    var finalReservedWish: WishModel?{
        didSet { renderUI() }
    }
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func renderUI() {
            wishName.text = wish?.name
            
            cellContainer.layer.borderColor = UIColor.red.cgColor
            cellContainer.layer.borderWidth = 0.5
            
            if let avatar = wish?.imagePath {
                wishImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
            } else {
                wishImage.image = UIImage(named: "placeholder")
            }
        }
        

}
