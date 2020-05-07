//
//  HomeVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift

private let reuseIdentifier = "homeCell"
private let itemsPerRow = 7

class HomeVC: BaseVC {
    
    //Buttons, labesl and stackviews outlets
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var firstSV: UIStackView!
    @IBOutlet weak var mainStackV: UIStackView!
    @IBOutlet weak var bannerView: UIView!
    
    //Colecction View outlets
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Home"
        setModifieres()
        setStacksView()
        welcomeBack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Home"
    }
    
    func setModifieres() {
        moreInfoButton.layer.cornerRadius = 15
        moreInfoButton.layer.borderWidth = 1
        moreInfoButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    func setStacksView() {
    }
    
    func welcomeBack() {
        let banner = NotificationBanner(title: "Hola!", subtitle: "Bienvenido de vuelta")
        banner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        banner.show()
        
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = firstCollectionView.dequeueReusableCell(withReuseIdentifier: "holaCelda", for: indexPath) as? MyCollectionViewCell
           
           cell?.myLabel.text = "Ineex: \(indexPath.row)"
           
           
           return cell!
       }
}
