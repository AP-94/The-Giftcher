//
//  WishDetailVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class WishDetailVC: ViewController {

    @IBOutlet weak var wishBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModifiers()
    }
    
    func setModifiers(){
        wishBackground.layer.borderColor = UIColor.red.cgColor
        wishBackground.layer.borderWidth = 2.0
        
    }
}
