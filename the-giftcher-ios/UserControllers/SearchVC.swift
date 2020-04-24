//
//  SearchVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class SearchVC: BaseVC {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchEngine: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Search"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Search"
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "miCelda", for: indexPath) as? MyCollectionViewCell
           
           cell?.myLabel.text = "Index: \(indexPath.row)"
           
           
           return cell!
       }
}
