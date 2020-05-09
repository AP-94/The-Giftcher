//
//  SearchVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchVC: ViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, WishesCellDelegate, NVActivityIndicatorViewable {
    
    let dataMapper = DataMapper()
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchEngine: UISearchBar!
    @IBOutlet weak var noWishesLabel: UILabel!
    var wishes: [WishModel?] = []
    var filteredData: [WishModel?] = []
    var selectedCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Buscar"
        self.searchEngine.delegate = self
        navigationModifier()
        loadData()
        tableViewModifiers()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Buscar"
    }
    
    /*func updateSearchResults(for searchController: UISearchController) {
        filteredData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (wishes as NSArray).filtered(using: searchPredicate)
        filteredData = array as! [WishModel?]

        self.tableView.reloadData()
    }*/
    
    @objc private func refreshData(_ sender: Any) {
        loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchEngine.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchEngine.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchEngine.resignFirstResponder()
    }
    
    func tableViewModifiers() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    func loadData() {
        print("Do Get All wishes request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.getAllWishesRequest() {
            success, result, error in
            if let result = result as? [WishModel] {
                self.wishes = result
                self.tableView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = wishes.count
        
        if count == 0 {
            noWishesLabel.isHidden = false
        } else {
            noWishesLabel.isHidden = true
        }
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WishesCell.identifier, for: indexPath) as? WishesCell {
            cell.wish = nil
            cell.wish = wishes[indexPath.row]
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
        if segue.identifier == "WishDetailSegue", let cell = sender as? WishesCell {
            selectedCell = cell
            
            if let wishDetailVC = segue.destination as? WishDetailVC, let indexPath = tableView.indexPath(for: cell) {
                wishDetailVC.wish = wishes[indexPath.row]
                print("WISH -> \(String(describing: wishDetailVC.wish?.name))")
            }
        }
    }
    
    func navigationModifier() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "degradado_navBar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        //self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1)
    }
}
