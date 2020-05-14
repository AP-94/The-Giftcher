//
//  AddFriendsVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class AddFriendsVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, FriendsOfUserCellDelegate, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchEngine: UISearchBar!
    @IBOutlet weak var noUsersFoundLabel: UILabel!
    
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    let refreshControl = UIRefreshControl()
    var friends: [UserFriendModel?] = []
    var filteredData = [UserFriendModel?]()
    var selectedCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Amigos"
        searchEngine.delegate = self
        searchEngine.searchTextField.clearButtonMode = .never
        navigationModifier()
        loadData()
        tableViewModifiers()
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
        
        tableView.reloadData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchEngine.endEditing(true)
        filteredData.removeAll()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchEngine.endEditing(true)
        filteredData.removeAll()
        searchEngine.searchTextField.text = ""
        loadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchEngine.resignFirstResponder()
        if searchEngine.text!.isEmpty {
            loadData()
        } else {
            filterContentForSearchText(searchEngine.text!)
            
        }
        
    }
    
    func tableViewModifiers() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
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
                
                self.tableView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = friends.count
        
        if count == 0 {
            noUsersFoundLabel.isHidden = false
        } else {
            noUsersFoundLabel.isHidden = true
        }
        
        if !searchEngine.searchTextField.text!.isEmpty {
            if filteredData.isEmpty {
                noUsersFoundLabel.isHidden = false
                noUsersFoundLabel.text = "Ningún resultado"
            } else {
                noUsersFoundLabel.isHidden = true
            }
            return filteredData.count
        } else {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user_friend", for: indexPath) as? AddFriendsTBCell {
            
            if !searchEngine.text!.isEmpty {
                cell.backgroundColor = UIColor.clear
                cell.friend = nil
                cell.friend = filteredData[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
            
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
        if segue.identifier == "friendDetail", let cell = sender as? AddFriendsTBCell {
            selectedCell = cell
            if let friendDetailVC = segue.destination as? FriendDetailVC, let indexPath = tableView.indexPath(for: cell) {
                friendDetailVC.friend = friends[indexPath.row]
                print("USER -> \(String(describing: friendDetailVC.friend?.name))")
            }
        }
    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "degradado_navBar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1)
    }
    
}
