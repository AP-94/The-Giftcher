//
//  ChoosePreferencesVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 16/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class ChoosePreferencesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func continueButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TutorialToHomeView", sender: nil)
    }
    
}
