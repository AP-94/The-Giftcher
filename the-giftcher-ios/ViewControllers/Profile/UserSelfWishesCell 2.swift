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
    
    var delegate: UserSelfWishesCellDelegate?
    var selectable = false
    var reserved = false
    
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var reservedContainer: UIView!
    
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
        
        if wish?.reserved == true && reserved == false {
            reservedLabel.isHidden = false
            cellContainer.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            reservedContainer.isHidden = false
            reservedLabel.layer.masksToBounds = true
            reservedLabel.layer.cornerRadius = 5.0
        } else {
            reservedLabel.isHidden = true
            reservedContainer.isHidden = true
            reservedLabel.layer.masksToBounds = true
        }
        
        }
        

}
