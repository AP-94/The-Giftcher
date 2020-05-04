//
//  SettingsVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 30/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class SettingsVC: BaseVC {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var termsCondButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var endSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ajustes"
        
        editProfileButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        termsCondButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        privacyPolicyButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        helpButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        endSessionButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)

    }
    
    @IBAction func logOutButton(_ sender: Any) {
        Session.clean()
        print("LogOUT Tapped...")
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = mainstoryboard.instantiateViewController(withIdentifier: "LoginView")
        
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.modalPresentationStyle = .fullScreen
    }
    
}
