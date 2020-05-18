//
//  ProfileVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
private let reuseIdentifier = "MyWishes"
private let itemsPerRow = 3
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

class ProfileVC: UIViewController, UserSelfWishesCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable{
    
    
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBirthdayLabel: UILabel!
    @IBOutlet weak var wishSegment: UISegmentedControl!
    @IBOutlet weak var userWishCollectionView: UICollectionView!
    @IBOutlet weak var noWishLabel: UILabel!
    
    var wishes: [WishModel?] = []
    var reservedWishes: [ReservedWishesModel?] = []
    var reservedWishes2: [ReservedFriendModel?] = []
    var reservedWishes3: [WishModel?] = []
    var selectedCell: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Perfil"
        navigationModifier()
        collectionViewModifiers()
        loadData()
        switchData()
        
        userProfileImage.layer.cornerRadius = 90
        userProfileImage.layer.borderWidth = 8
        userProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        
        userNameLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        userBirthdayLabel.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        callInfo()
        setAvatar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDataNoti(_:)), name: .didEditProfile, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Perfil"
        callInfo()
        setAvatar()
        loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = wishes.count
        let count2 = reservedWishes3.count
        
        switch wishSegment.selectedSegmentIndex {
        case 0:
            if count == 0 && wishes.isEmpty {
                noWishLabel.isHidden = false
            } else {
                noWishLabel.isHidden = true
            }
            return count
        case 1:
            if count2 == 0 && reservedWishes3.isEmpty {
                noWishLabel.isHidden = false
            } else {
                noWishLabel.text = "No tienes deseos reservados :("
                noWishLabel.isHidden = true
            }
            return count2
        default:
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = userWishCollectionView.dequeueReusableCell(withReuseIdentifier: "MyWishes", for: indexPath) as? UserSelfWishesCell {
            
            
            if !wishes.isEmpty || !reservedWishes3.isEmpty {
                if wishSegment.selectedSegmentIndex == 0 {
                    cell.backgroundColor = UIColor.clear
                    cell.wish = nil
                    cell.wish = wishes[indexPath.row]
                    cell.delegate = self
                    return cell
                } else if wishSegment.selectedSegmentIndex == 1 {
                    cell.backgroundColor = UIColor.clear
                    cell.wish = nil
                    cell.wish = reservedWishes3[indexPath.row]
                    cell.delegate = self
                    return cell
                }
                
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    @objc private func refreshData(_ sender: Any) {
        switch wishSegment.selectedSegmentIndex {
        case 0:
            loadData()
        case 1:
            switchData()
        default:
            loadData()
        }
    }
    
    @objc private func refreshDataNoti(_ notification:Notification) {
        callInfo()
        setAvatar()
    }
    
    func callInfo(){
        let user = Session.current.userModel
        let name = user?.name ?? ""
        let lastName = user?.lastName ?? ""
        let userName = user?.username ?? ""
        
        userNameLabel.text = "\(name) \(lastName) (\(userName))"
        userBirthdayLabel.text = user?.birthday ?? ""
    }
    
    func setAvatar() {
        userProfileImage.image = nil
        if let avatar = Session.current.userModel?.imagePath {
            userProfileImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        }
    }
    
    func collectionViewModifiers() {
        userWishCollectionView.backgroundColor = UIColor.clear
        userWishCollectionView.refreshControl = refreshControl
        userWishCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "degradado_navBar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        //self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1)
    }
    
    func loadData() {
        print("Do Get All wishes request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.getAllWishesOfUserRequest() {
            success, result, error in
            if let result = result as? [WishModel] {
                self.wishes.removeAll()
                self.wishes = result
                self.userWishCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func switchData() {
        print("Do Get All reserved wishes request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.getReservedWishesRequest() {
            success, result, error in
            if let result = result as? ReservedWishesModel {
                self.reservedWishes.removeAll()
                self.reservedWishes2.removeAll()
                self.reservedWishes3.removeAll()
                
                self.reservedWishes2 = result.reservedWishes
                for friend in self.reservedWishes2 {
                    self.reservedWishes3.append(contentsOf: (friend?.friendReservedWishes)!)
                }
                
                self.userWishCollectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func wishChangeSegment(_ sender: UISegmentedControl) {
        switch wishSegment.selectedSegmentIndex {
        case 0:
            loadData()
        default:
            switchData()
        }
        self.userWishCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WishDetailSegue", let cell = sender as? UserSelfWishesCell {
            selectedCell = cell
            
            switch wishSegment.selectedSegmentIndex {
            case 0:
                if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = userWishCollectionView.indexPath(for: cell) {
                    wishDetailVC.wish = wishes[indexPath.row]
                    wishDetailVC.wishOfUser = true
                    print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                }
            case 1:
                if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = userWishCollectionView.indexPath(for: cell) {
                    wishDetailVC.wish = reservedWishes3[indexPath.row]
                    wishDetailVC.wishOfUser = true
                    print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                }
            default:
                if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = userWishCollectionView.indexPath(for: cell) {
                    wishDetailVC.wish = wishes[indexPath.row]
                    print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
                }
            }
            
            
        }
        
        
        
    }
}



