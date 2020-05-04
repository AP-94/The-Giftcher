//
//  WishDetailVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class WishDetailVC: ViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uiViewsOutlet: UIView!
    @IBOutlet weak var uiViews2Outlet: UIView!
    @IBOutlet weak var uiViews3Outlet: UIView!
    @IBOutlet weak var shareButtonView: UIView!
    @IBOutlet weak var buttonSaveView: UIView!
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var wishPrice: UILabel!
    @IBOutlet weak var wishDescription: UILabel!
    @IBOutlet weak var wishCategory: UILabel!
    @IBOutlet weak var wishStore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Detalle"
        setModifiers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           self.tabBarController?.title = "Detalle"
       }
       
    
    func setModifiers(){
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 15
        
        uiViewsOutlet.layer.borderColor = UIColor.red.cgColor
        uiViewsOutlet.layer.borderWidth = 2.0
        uiViewsOutlet.layer.cornerRadius = 15
        
        uiViews2Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews2Outlet.layer.borderWidth = 2.0
        uiViews2Outlet.layer.cornerRadius = 15
        
        uiViews3Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews3Outlet.layer.borderWidth = 2.0
        uiViews3Outlet.layer.cornerRadius = 15
        
        shareButtonView.layer.cornerRadius = 10
        buttonSaveView.layer.cornerRadius = 10
        
    }
    
    @IBAction func saveWish(_ sender: UIButton) {
    }
    
    @IBAction func shareWish(_ sender: Any) {
    }
    
}
