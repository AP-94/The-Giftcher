//
//  FriendDetailVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class FriendDetailVC: UIViewController, NVActivityIndicatorViewable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var friend: UserFriendModel?
    var dataMapper = DataMapper()
    var friendWishes: [WishModel?] = []
    var cleanBirthday: String?
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    var selectedCell: UICollectionViewCell?
    private let refreshControl = UIRefreshControl()
    let rightSideOptionButton = UIBarButtonItem()
    @IBOutlet weak var noWishesLabel: UILabel!
    var friends: [UserFriendModel?] = []
    var friendRequest: Bool? = false
    var friendRequestId: Int?
    
    
    //Outlets
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var friendBirthday: UILabel!
    @IBOutlet weak var wishBanner: UILabel!
    @IBOutlet weak var friendWishesCollectionView: UICollectionView!
    @IBOutlet weak var wishesCount: UILabel!
    @IBOutlet weak var addFriend: UIButton!
    @IBOutlet weak var acceptRequestButton: UIButton!
    @IBOutlet weak var rejectRequestButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModifiers()
        self.navigationItem.title =  friend?.username!
        fillInfoOfFriend()
        collectionViewModifiers()
        friendsRequest()
        loadData()
        getFriendsofUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title =  friend?.username!
        fillInfoOfFriend()
    }
    
    func fillInfoOfFriend() {
        dateConverter()
        friendBirthday.text = cleanBirthday
        
        let name = friend?.name ?? ""
        let lastName = friend?.lastName ?? ""
        let fullName = "\(name) \(lastName)"
        friendName.text = fullName
        
        if let avatar = friend?.imagePath {
            userProfileImage.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            userProfileImage.image = UIImage(named: "profile_placeholder")
        }
    }
    
    func viewModifiers() {
        friendName.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        friendBirthday.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        userProfileImage.layer.cornerRadius = 65
        userProfileImage.layer.borderWidth = 5
        userProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onRightButtonTap))
        
        addFriend.layer.cornerRadius = 10
        addFriend.layer.borderWidth = 1
        addFriend.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        acceptRequestButton.layer.cornerRadius = 10
        acceptRequestButton.layer.borderWidth = 1
        acceptRequestButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        rejectRequestButton.layer.cornerRadius = 10
        rejectRequestButton.layer.borderWidth = 1
        rejectRequestButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @objc func onRightButtonTap() {
        showConfirm() {
            self.eliminateFriend()
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: .didEliminateFriend, object: nil)
        }
    }
    
    
    func loadData() {
        print("Do Get All wishes of friend request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        let userId = friend?.friendId!
        dataMapper.getFriendWishesRequest(userId: userId!) {
            success, result, error in
            if let result = result as? [WishModel] {
                self.friendWishes.removeAll()
                self.friendWishes = result
                self.friendWishesCollectionView.reloadData()
                self.wishesCount.text = String(self.friendWishes.count)
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    func dateConverter() {
        let birthday = friend?.birthday ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: birthday) {
            cleanBirthday = dateFormatterPrint.string(from: date)
        }
    }
    
    func collectionViewModifiers() {
        friendWishesCollectionView.refreshControl = refreshControl
        friendWishesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        loadData()
    }
    
    func showConfirm(completion: @escaping () -> Void) {
        let message = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Eliminar amigo", style: .destructive) { (UIAlertAction) -> Void in
            print("Eliminando amigo")
            completion()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) -> Void in
            print("cancel")
        }
        
        message.addAction(ok)
        message.addAction(cancel)
        
        self.present(message, animated: true, completion: nil)
    }
    
    //MARK: COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = friendWishes.count
        
        if count == 0 {
            noWishesLabel.isHidden = false
        } else {
            noWishesLabel.isHidden = true
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = friendWishesCollectionView.dequeueReusableCell(withReuseIdentifier: "FriendWishCell", for: indexPath) as? FriendWishCell {
            
            cell.backgroundColor = UIColor.clear
            cell.wish = nil
            cell.wish = friendWishes[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WishDetailSegue", let cell = sender as? FriendWishCell {
            selectedCell = cell
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = friendWishesCollectionView.indexPath(for: cell) {
                wishDetailVC.wish = friendWishes[indexPath.row]
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
            }
        }
    }
    
    
    func eliminateFriend() {
        print("Do eliminate friend")
        dataMapper.deleteFriendRequest(friendshipId: friend?.id!) {
            success, result, error in
            if let result = result as? SingletonModel {
                print(result.message!)
            }
            
        }
    }
    
    @IBAction func addFriendRequest(_ sender: Any) {
        print("Do Add friend request")
        let inputFriendRequest = InputFriendRequest(friendRequestId: friend?.friendId!)
        dataMapper.friendPostRequest(inputFriendRequest: inputFriendRequest) {
            success, result, error in
            if let result = result as? SingletonModel {
                print(result.message!)
                let banner = NotificationBanner(title: "Enviada", subtitle: "Tu petición de amistad fue enviada", style: .info)
                banner.show()
                self.addFriend.setTitle("Enviado", for: .normal)
                self.addFriend.isEnabled = false
            }
            
        }
    }
    
    func getFriendsofUser() {
        if !friendRequest! {
            print("Do get friends of user request")
            dataMapper.getAllFriendsOfUserRequest() {
                success, result, error in
                if let result = result as? FriendsModel {
                    self.friends.removeAll()
                    for friend in result.friends {
                        self.friends.append(friend)
                    }
                    self.checkFriendship()
                }
            }
        }
    }
    
    func checkFriendship() {
        for user in friends {
            if user?.friendId == friend?.friendId {
                addFriend.isEnabled = false
                addFriend.setTitle("Amigos", for: .normal)
            }
        }
    }
    
    func friendsRequest() {
        if friendRequest! {
            addFriend.isHidden = true
            acceptRequestButton.isHidden = false
            rejectRequestButton.isHidden = false
        }
    }
    
    @IBAction func acceptFriendRequest(_ sender: Any) {
        print("Do Accept Friend Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.confirmFriendRequest(idFriendRequest: friendRequestId!) {
            success, result, error in
            if let result = result as? SingletonModel {
                print(result)
                self.navigationController?.popViewController(animated: true)
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                NotificationCenter.default.post(name: .didAcceptedRequest, object: nil)
            }
        }
    }
    
    @IBAction func rejectRequest(_ sender: Any) {
        print("Do Reject Friend Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.deleteFriendRequest(friendshipId: friendRequestId!) {
            success, result, error in
            if let result = result as? SingletonModel {
                print(result)
                self.navigationController?.popViewController(animated: true)
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                NotificationCenter.default.post(name: .didAcceptedRequest, object: nil)
            }
        }
    }
}
