//
//  HomeVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift
import AVKit
import Photos

private let reuseIdentifier = "homeCell"
private let itemsPerRow = 7
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


class HomeVC: UIViewController, NVActivityIndicatorViewable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyCollectionViewCellDelegate, SecondCategoryCellDelegate, ThirdCategoryCellDelegate, FourthCategoryCellDelegate {
    
    //Buttons, labesl and stackviews outlets
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var firstSV: UIStackView!
    @IBOutlet weak var mainStackV: UIStackView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var firstCVLabel: UILabel!
    @IBOutlet weak var secondCVLabel: UILabel!
    @IBOutlet weak var thirdCVLabel: UILabel!
    @IBOutlet weak var fourthCVLabel: UILabel!
    
    var wish: WishModel?
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    var user = Session.current.userModel
    private let refreshControl = UIRefreshControl()
    var categoryList: [Int?] = []
    var categoryStringList: [String?] = []
    var tutorialDone = false
    
    //Colecction View outlets
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    @IBOutlet weak var fourthCollectionView: UICollectionView!
    
    var firstCatWishes: [WishModel?] = []
    var secondCatWishes: [WishModel?] = []
    var thirdCatWishes: [WishModel?] = []
    var fourthCatWishes: [WishModel?] = []
    var selectedCell: UICollectionViewCell?
    var selectedCell2: UICollectionViewCell?
    var selectedCell3: UICollectionViewCell?
    var selectedCell4: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Home"
        self.tabBarController?.navigationItem.hidesBackButton = true
        setModifieres()
        welcomeBack()
        requestPermissions()
        loadFirstCatData()
        loadSecondCatData()
        loadThirdCatData()
        loadFourthCatData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Home"
        loadFriendsRequests()
        //setLabels()
    }
    
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //           loadFirstCatData()
    //        loadSecondCatData()
    //        loadThirdCatData()
    //        loadFourthCatData()
    //
    //       }
    
    func setModifieres() {
        moreInfoButton.layer.cornerRadius = 15
        moreInfoButton.layer.borderWidth = 1
        moreInfoButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setLabels() {
        firstCVLabel.text = categoryStringList.getElement(at: 0) ?? ""
        secondCVLabel.text = categoryStringList.getElement(at: 1) ?? ""
        thirdCVLabel.text = categoryStringList.getElement(at: 2) ?? ""
        fourthCVLabel.text = categoryStringList.getElement(at: 3) ?? ""
    }
    
    func collectionViewModifiers() {
        firstCollectionView.backgroundColor = UIColor.clear
        firstCollectionView.refreshControl = refreshControl
        firstCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @IBAction func goToWebButton(_ sender: Any) {
        let stringUrl = "http://www.thegiftcher.com"
        let url = URL(string: stringUrl)
        UIApplication.shared.open(url!)
    }
    
    func welcomeBack() {
        let banner = NotificationBanner(title: "Hola!", subtitle: "Bienvenido de vuelta")
        banner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        banner.show()
        
    }
    
    @objc private func refreshData(_ sender: Any) {
        loadFirstCatData()
        loadSecondCatData()
        loadThirdCatData()
        loadFourthCatData()
    }
    
    func requestPermissions() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                
            } else {
                
            }
        }
    }
    
    func loadFirstCatData() {
        print("Do Get All wishes from Category Id Request1")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        //let categoryId = categoryList.getElement(at: 0) ?? 1
        dataMapper.getAllWishesByCategoryIdRequest( categoryId: 2) {
            success, result, error in
            if let result = result as? [WishModel] {
                
                self.firstCatWishes.removeAll()
                self.firstCatWishes = result
                self.firstCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadSecondCatData() {
        print("Do Get All wishes from Category Id Request2")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        //let categoryId = categoryList.getElement(at: 1) ?? 2
        dataMapper.getAllWishesByCategoryIdRequest( categoryId: 2) {
            success, result, error in
            if let result = result as? [WishModel] {
                
                self.secondCatWishes.removeAll()
                self.secondCatWishes = result
                self.secondCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadThirdCatData() {
        print("Do Get All wishes from Category Id Request3")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        //let categoryId = categoryList.getElement(at: 2) ?? 3
        dataMapper.getAllWishesByCategoryIdRequest( categoryId: 2) {
            success, result, error in
            if let result = result as? [WishModel] {
                
                self.thirdCatWishes.removeAll()
                self.thirdCatWishes = result
                self.thirdCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadFourthCatData() {
        print("Do Get All wishes from Category Id Request4")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        //let categoryId = categoryList.getElement(at: 3) ?? 4
        dataMapper.getAllWishesByCategoryIdRequest( categoryId: 2) {
            success, result, error in
            if let result = result as? [WishModel] {
                
                self.fourthCatWishes.removeAll()
                self.fourthCatWishes = result
                self.fourthCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count1 = firstCatWishes.count
        let count2 = secondCatWishes.count
        let count3 = thirdCatWishes.count
        let count4 = fourthCatWishes.count
        
        if collectionView == secondCollectionView {
            return count2
        }
        
        if collectionView == thirdCollectionView {
            return count3
        }
        
        if collectionView == fourthCollectionView {
            return count4
        }
        
        return count1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = firstCollectionView.dequeueReusableCell(withReuseIdentifier: "catOne", for: indexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.wish = nil
        cell.wish = firstCatWishes[indexPath.row]
        cell.delegate = self
        
        if collectionView == secondCollectionView {
            let cell2 = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "catTwo", for: indexPath) as! SecondCategoryCell
            
            cell2.backgroundColor = UIColor.clear
            cell2.wish = nil
            cell2.wish = secondCatWishes[indexPath.row]
            cell2.delegate = self
            return cell2
        }
        
        if collectionView == thirdCollectionView {
            let cell3 = thirdCollectionView.dequeueReusableCell(withReuseIdentifier: "catThree", for: indexPath) as! ThirdCategoryCell
            
            cell3.backgroundColor = UIColor.clear
            cell3.wish = nil
            cell3.wish = thirdCatWishes[indexPath.row]
            cell3.delegate = self
            return cell3
        }
        
        if collectionView == thirdCollectionView {
            let cell3 = thirdCollectionView.dequeueReusableCell(withReuseIdentifier: "catThree", for: indexPath) as! ThirdCategoryCell
            
            cell3.backgroundColor = UIColor.clear
            cell3.wish = nil
            cell3.wish = thirdCatWishes[indexPath.row]
            cell3.delegate = self
            return cell3
        }
        
        if collectionView == fourthCollectionView {
            let cell4 = fourthCollectionView.dequeueReusableCell(withReuseIdentifier: "catFour", for: indexPath) as! FourthCategoryCell
            
            cell4.backgroundColor = UIColor.clear
            cell4.wish = nil
            cell4.wish = fourthCatWishes[indexPath.row]
            cell4.delegate = self
            return cell4
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "WishDetailSegue", let cell = sender as? MyCollectionViewCell {
            selectedCell = cell
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = firstCollectionView.indexPath(for: cell) {
                wishDetailVC.wish = firstCatWishes[indexPath.row]
                wishDetailVC.wishOfUser = true
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                
            }
            
        } else if segue.identifier == "WishDetailSegue2", let cell2 = sender as? SecondCategoryCell {
            selectedCell2 = cell2
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = secondCollectionView.indexPath(for: cell2) {
                wishDetailVC.wish = secondCatWishes[indexPath.row]
                wishDetailVC.wishOfUser = true
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                
            }
            
        } else if segue.identifier == "WishDetailSegue3", let cell = sender as? ThirdCategoryCell {
            selectedCell3 = cell
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = thirdCollectionView.indexPath(for: cell) {
                wishDetailVC.wish = thirdCatWishes[indexPath.row]
                wishDetailVC.wishOfUser = true
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                
            }
            
        } else if segue.identifier == "WishDetailSegue4", let cell = sender as? FourthCategoryCell {
            selectedCell4 = cell
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = fourthCollectionView.indexPath(for: cell) {
                wishDetailVC.wish = fourthCatWishes[indexPath.row]
                wishDetailVC.wishOfUser = true
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                
            }
            
        }
        
    }
    
    func loadFriendsRequests() {
        print("Do get friends requests request")
        dataMapper.getFriendsRequests() {
            success, result, error in
            if let result = result as? [FriendRequestModel] {
                if result.count != 0 {
                    let banner = NotificationBanner(title: "Tienes peticiones de amistad", subtitle: "Pulsa aquí para ver las peticiones", style: .info)
                    banner.autoDismiss = false
                    banner.onTap = {
                        banner.dismiss()
                        self.performSegue(withIdentifier: "HomeToUserFriendsRequestsSegue", sender: nil)
                    }
                    banner.onSwipeUp = {
                        banner.dismiss()
                    }
                    banner.show()
                }
            }
        }
    }
    
}

extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}



