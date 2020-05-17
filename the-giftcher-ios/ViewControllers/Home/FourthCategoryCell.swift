//
//  FourthCategoryCell.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 17/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

internal protocol FourthCategoryCellDelegate {
    
}

class FourthCategoryCell: UICollectionViewCell {
    
    var delegate: FourthCategoryCellDelegate?
    var selectable = false
    var wish: WishModel?{
        didSet { renderUI() }
    }
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    func renderUI() {
        cellLabel.text = wish?.name
        
        cellContainer.layer.borderColor = UIColor.red.cgColor
        cellContainer.layer.borderWidth = 0.5
        
        if let avatar = wish?.imagePath {
            cellImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            cellImage.image = UIImage(named: "placeholder")
        }
    }
}
