//
//  ChoosePreferencesVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 16/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class ChoosePreferencesVC: UIViewController {

    @IBOutlet weak var videogamesCat: UIButton!
    @IBOutlet weak var homeCat: UIButton!
    @IBOutlet weak var motorCat: UIButton!
    @IBOutlet weak var homeAppliancesCat: UIButton!
    @IBOutlet weak var fashionCat: UIButton!
    @IBOutlet weak var gardenCat: UIButton!
    @IBOutlet weak var televisionCat: UIButton!
    @IBOutlet weak var musicCat: UIButton!
    @IBOutlet weak var photoCat: UIButton!
    @IBOutlet weak var cellphoneCat: UIButton!
    @IBOutlet weak var informaticCat: UIButton!
    @IBOutlet weak var sportsCat: UIButton!
    @IBOutlet weak var bookCat: UIButton!
    @IBOutlet weak var childsCat: UIButton!
    @IBOutlet weak var farmingCat: UIButton!
    @IBOutlet weak var servicesCat: UIButton!
    @IBOutlet weak var collectiblesCat: UIButton!
    @IBOutlet weak var constructionCat: UIButton!
    @IBOutlet weak var othersCat: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        customSettings()

    }
    
    func customSettings() {
        videogamesCat.whiteAndRedRounded()
    }
    
    @IBAction func continueButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TutorialToHomeView", sender: nil)
    }
    
    @IBAction func selectedVideoGameCat(_ sender: Any) {
        videogamesCat.whiteAndRedRoundedSelected()
    }
}
