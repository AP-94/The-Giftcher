//
//  UIButtonExtension.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 15/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

extension UIButton {

    // round border
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    func whiteAndRedRounded() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        backgroundColor = UIColor.white
        setTitleColor(UIColor.themeMoreButton, for: .normal)
    }
    
    func whiteAndRedRoundedSelected() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        backgroundColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1)
        setTitleColor(UIColor.white, for: UIControl.State.highlighted)
    }
    
    // Bounce
    func bounce() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .identity
            })
        }
    }
}

extension UIColor {
    static var themeMoreButton = UIColor.init(red: 217/255, green: 48/255, blue: 69/225, alpha: 1)
}
