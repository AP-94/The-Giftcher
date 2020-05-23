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
        containerView.layer.borderWidth = 0.5
        
        if let avatar = wish?.imagePath {
            wishImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            wishImage.image = UIImage(named: "placeholder")
        }
    }
    
}

