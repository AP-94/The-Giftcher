//
//  HomeVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class HomeVC: BaseVC{
    
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var firstSV: UIStackView!
    @IBOutlet weak var mainStackV: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Home"
        setLabels()
        setStacksView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Home"
    }
    
    func setLabels() {
        moreInfoButton.layer.cornerRadius = 15
        moreInfoButton.layer.borderWidth = 1
        moreInfoButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setStacksView() {
    }
    
    

}
