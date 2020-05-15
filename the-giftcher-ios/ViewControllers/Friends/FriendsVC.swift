//
//  FriendsVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class FriendsVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, FriendsOfUserCellDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var friendSearchBar: UISearchBar!
    @IBOutlet weak var noFriendsLabel: UILabel!
    @IBOutlet weak var addFriendsBT: UIButton!
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    private let refreshControl = UIRefreshControl()
    var friends: [UserFriendModel?] = []
    var filteredData = [UserFriendModel?]()
    var selectedCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Amigos"
        friendSearchBar.delegate = self
        friendSearchBar.searchTextField.clearButtonMode = .never
        navigationModifier()
        loadData()
        tableViewModifiers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDataNoti(_:)), name: .didEliminateFriend, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Amigos"
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        print("Filtrando contenido por: \(searchText)")
        filteredData.removeAll()
        var text = searchText.lowercased()
        text = text.folding(options: .diacriticInsensitive, locale: NSLocale.current)
        
        for index in friends{
            if var name = index?.name?.lowercased(), var userName = index?.username?.lowercased(), var lastName = index?.lastName?.lowercased() {
                name = name.folding(options: .diacriticInsensitive, locale: NSLocale.current)
                userName = userName.folding(options: .diacriticInsensitive, locale: NSLocale.current)
                lastName = lastName.folding(options: .diacriticInsensitive, locale: NSLocale.current)
                if name.lowercased().contains(text.lowercased()) || userName.lowercased().contains(text.lowercased()) || lastName.lowercased().contains(text.lowercased()) {
                    filteredData.append(index)
                }
            }
        }
        
        friendTableView.reloadData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        loadData()
    }
    
    @objc private func refreshDataNoti(_ notification:Notification) {
        loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        friendSearchBar.endEditing(true)
        filteredData.removeAll()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        friendSearchBar.endEditing(true)
        filteredData.removeAll()
        friendSearchBar.searchTextField.text = ""
        loadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        friendSearchBar.resignFirstResponder()
        if friendSearchBar.text!.isEmpty {
            loadData()
        } else {
            filterContentForSearchText(friendSearchBar.text!)
            
        }
        
    }
    
    func tableViewModifiers() {
        friendTableView.separatorStyle = .none
        friendTableView.backgroundColor = UIColor.clear
        friendTableView.refreshControl = refreshControl
        friendTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    func loadData() {
        print("Do get friends of user request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.getAllFriendsOfUserRequest() {
            success, result, error in
            if let result = result as? FriendsModel {
                self.friends.removeAll()
                for friend in result.friends {
                    self.friends.append(friend)
                }

                self.friendTableView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = friends.count
        
        if count == 0 {
            noFriendsLabel.isHidden = false
        } else {
            noFriendsLabel.isHidden = true
        }
        
        if !friendSearchBar.searchTextField.text!.isEmpty {
            if filteredData.isEmpty {
                noFriendsLabel.isHidden = false
                noFriendsLabel.text = "Ningún resultado"
            } else {
                noFriendsLabel.isHidden = true
            }
            return filteredData.count
        } else {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = friendTableView.dequeueReusableCell(withIdentifier: FriendsOfUserCell.identifier, for: indexPath) as? FriendsOfUserCell {
            
            if !friendSearchBar.text!.isEmpty {
                cell.backgroundColor = UIColor.clear
                cell.friend = nil
                cell.friend = filteredData[indexPath.row]
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
            
            cell.backgroundColor = UIColor.clear
            cell.friend = nil
            cell.friend = friends[indexPath.row]
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendDetail", let cell = sender as? FriendsOfUserCell {
            selectedCell = cell
            if let friendDetailVC = segue.destination as? FriendDetailVC, let indexPath = friendTableView.indexPath(for: cell) {
                if !friendSearchBar.text!.isEmpty {
                    friendDetailVC.friend = filteredData[indexPath.row]
                } else {
                    friendDetailVC.friend = friends[indexPath.row]
                }
                print("FRIEND -> \(String(describing: friendDetailVC.friend?.name))")
            }
        }
    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "degradado_navBar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1)
    }
    @IBAction func addFriendsButton(_ sender: UIButton) {
        addFriendsBT.bounce()
        self.performSegue(withIdentifier: "AddFriends", sender: nil)
    }
    
}

