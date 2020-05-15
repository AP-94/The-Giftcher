//
//  FriendRequestVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 14/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class FriendRequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FriendsOfUserCellDelegate, NVActivityIndicatorViewable {
    
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    var friends: [UserModel?] = []
    var selectedCell: UITableViewCell?
    var userTodeliver: UserFriendModel?
    var users: [Int?] = []
    var friendRequestsIds: [Int?] = []
    
    //Outlets
    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFriendsRequestLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Peticiones de Amistad"
        navigationModifier()
        loadData()
        tableViewModifiers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData(_:)), name: .didAcceptedRequest, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = "Peticiones de Amistad"
    }
    
    func tableViewModifiers() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
    }
    
    @objc private func refreshData(_ notification:Notification) {
        loadData()
    }
    
    func loadData() {
        print("Do get friend requests request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.getFriendsRequests() {
            success, result, error in
            if let result = result as? [FriendRequestModel] {
                self.friendRequestsIds.removeAll()
                self.users.removeAll()
                let orderedResult = result.sorted(by: { $0.userId! > $1.userId! })
                for request in orderedResult   {
                    self.friendRequestsIds.append(request.id)
                    self.users.append(request.userId)
                }
                self.loadUsers()
            }
            
        }
    }
    
    func loadUsers() {
        print("Do get users request")
        dataMapper.getAllUsersRequest() {
            success, result, error in
            if let result = result as? [UserModel] {
                self.friends.removeAll()
                for user in result {
                    for id in self.users {
                        if user.id == id {
                            self.friends.append(user)
                        }
                    }
                }
                self.tableView.reloadData()
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            }
            
        }
        
    }
    
    // MARK: TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = friends.count
        
        if count == 0 {
            noFriendsRequestLabel.isHidden = false
        } else {
            noFriendsRequestLabel.isHidden = true
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user_friend", for: indexPath) as? FriendRequestTBCell {
            
            cell.backgroundColor = UIColor.clear
            cell.friend = nil
            cell.friend = friends[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestToDetail", let cell = sender as? AddFriendsTBCell {
            selectedCell = cell
            if let friendDetailVC = segue.destination as? FriendDetailVC, let indexPath = tableView.indexPath(for: cell) {
                convertUserModelToFriendsModel(user: friends[indexPath.row]!)
                friendDetailVC.friendRequest = true
                friendDetailVC.friend = userTodeliver
                friendDetailVC.friendRequestId = friendRequestsIds[indexPath.row]
                print("FRIEND ID -> \(userTodeliver?.friendId ?? 0)")
                print("FRIEND REQUEST ID -> \(friendRequestsIds[indexPath.row] ?? 0)")
            }
        }
    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "degradado_navBar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1)
    }
    
    func convertUserModelToFriendsModel(user: UserModel) {
     userTodeliver = UserFriendModel()
     userTodeliver?.name = user.name ?? ""
     userTodeliver?.username = user.username ?? ""
     userTodeliver?.birthday = user.birthday ?? ""
     userTodeliver?.lastName = user.lastName ?? ""
     userTodeliver?.mail = user.mail ?? ""
     userTodeliver?.imageName = user.imageName ?? ""
     userTodeliver?.imagePath = user.imagePath ?? ""
     userTodeliver?.id = 0
     userTodeliver?.friendId = user.id!
     }
    
    
}
