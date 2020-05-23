//
//  MyCollectionViewCell.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 23/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol MyCollectionViewCellDelegate {
    
}

class MyCollectionViewCell: UICollectionViewCell {
    
    var delegate: MyCollectionViewCellDelegate?
    var selectable = false
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    @IBOutlet weak var wishNam: UILabel!
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var cellContainer: UIView!
    
    func renderUI() {
        wishNam.text = wish?.name
        
        cellContainer.layer.borderColor = UIColor.red.cgColor
        cellContainer.layer.borderWidth = 0.5
        
        if let avatar = wish?.imagePath {
            wishImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            wishImage.image = UIImage(named: "placeholder")
        }
    }
}
