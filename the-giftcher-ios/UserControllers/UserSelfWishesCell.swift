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
        
//        override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//            if selectable {
//                if highlighted {
//                    self.alpha = 0.6
//                } else {
//                    self.alpha = 1.0
//                }
//            }
//        }
//
//    }
//
//    extension UIView {
//        var parentViewController: UIViewController? {
//            var parentResponder: UIResponder? = self
//            while parentResponder != nil {
//                parentResponder = parentResponder!.next
//                if parentResponder is UIViewController {
//                    return parentResponder as? UIViewController
//                }
//            }
//            return nil
//        }

}
