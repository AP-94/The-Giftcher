//
//  WishesCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 08/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol WishesCellDelegate {
    
}

internal class WishesCell: UITableViewCell {
    
    static let identifier = "WishCellIdentifier"
    var delegate: WishesCellDelegate?
    var selectable = false
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    //Outlets
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var wishDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wishImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func renderUI() {
        wishName.text = wish?.name
        wishDescription.text = wish?.description
        
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.borderWidth = 2.0
        
        if let avatar = wish?.imagePath {
            wishImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            wishImage.image = UIImage(named: "placeholder")
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if selectable {
            if highlighted {
                self.alpha = 0.6
            } else {
                self.alpha = 1.0
            }
        }
    }

}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}
