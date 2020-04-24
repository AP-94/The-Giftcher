//
//  AddFriendsVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 24/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class AddFriendsVC: FriendsVC, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var findNewFriendsSearchBar: UISearchBar!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var foundFriendsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    

}
