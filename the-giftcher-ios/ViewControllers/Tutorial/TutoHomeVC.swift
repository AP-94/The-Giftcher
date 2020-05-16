//
//  TutoHomeVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 16/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class TutoHomeVC: UIViewController {

    @IBOutlet weak var nextTutoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextTutoAction(_ sender: UIButton) {
        nextTutoButton.bounce()
        self.performSegue(withIdentifier: "Tuto2", sender: nil)
    }
    

}
