//
//  ChoosePreferencesVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 16/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift

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
    
    var counter = 0
    var categoryArray: [Int] = []
    var categoryStringArray: [String] = []
    var categoryInt: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        customSettings()
    }
    
    func customSettings() {
        videogamesCat.whiteAndRedRounded()
        homeCat.whiteAndRedRounded()
        motorCat.whiteAndRedRounded()
        homeAppliancesCat.whiteAndRedRounded()
        fashionCat.whiteAndRedRounded()
        gardenCat.whiteAndRedRounded()
        televisionCat.whiteAndRedRounded()
        musicCat.whiteAndRedRounded()
        photoCat.whiteAndRedRounded()
        cellphoneCat.whiteAndRedRounded()
        informaticCat.whiteAndRedRounded()
        sportsCat.whiteAndRedRounded()
        bookCat.whiteAndRedRounded()
        childsCat.whiteAndRedRounded()
        farmingCat.whiteAndRedRounded()
        servicesCat.whiteAndRedRounded()
        collectiblesCat.whiteAndRedRounded()
        constructionCat.whiteAndRedRounded()
        othersCat.whiteAndRedRounded()
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if counter == 4 {
            fillCategoiresArray()
            Session.current.userCategories = categoryArray
            Session.save()
            self.performSegue(withIdentifier: "TutorialToHomeView", sender: nil)
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "Por favor selecciona 4 categorías antes de avanzar", style: .warning)
            banner.show()
        }
    }
    
    func fillCategoiresArray() {
        let buttonsArray = [videogamesCat,homeCat,motorCat,homeAppliancesCat,fashionCat,gardenCat,televisionCat,musicCat,photoCat,cellphoneCat,informaticCat,sportsCat,bookCat,childsCat,farmingCat,servicesCat,collectiblesCat,constructionCat,othersCat]
        
        for button in buttonsArray {
            if button!.isSelected {
                setCategory(category: (button?.currentTitle)!)
                categoryStringArray.append((button?.currentTitle)!)
                categoryArray.append(categoryInt!)
            }
        }
    }
    
    @IBAction func selectedVideoGameCat(_ sender: UIButton) {
        setButton(button: videogamesCat)
    }
    @IBAction func selectedHomeCat(_ sender: UIButton) {
        setButton(button: homeCat)
    }
    @IBAction func selectedMotorCat(_ sender: UIButton) {
        setButton(button: motorCat)
    }
    @IBAction func selectedHomeApliCat(_ sender: UIButton) {
        setButton(button: homeAppliancesCat)
    }
    @IBAction func selectedFashionCat(_ sender: UIButton) {
        setButton(button: fashionCat)
    }
    @IBAction func selectedGardenCat(_ sender: UIButton) {
        setButton(button: gardenCat)
    }
    @IBAction func selectedTVCat(_ sender: UIButton) {
        setButton(button: televisionCat)
    }
    @IBAction func selectedMusicCat(_ sender: UIButton) {
        setButton(button: musicCat)
    }
    @IBAction func selectedFotoCat(_ sender: UIButton) {
        setButton(button: photoCat)
    }
    @IBAction func selectedCellPhoneCat(_ sender: UIButton) {
        setButton(button: cellphoneCat)
    }
    @IBAction func selectedInformaticCat(_ sender: UIButton) {
        setButton(button: informaticCat)
    }
    @IBAction func selectedSportsCat(_ sender: UIButton) {
        setButton(button: sportsCat)
    }
    @IBAction func selectedBooksCat(_ sender: UIButton) {
        setButton(button: bookCat)
    }
    @IBAction func selectedChildCat(_ sender: UIButton) {
        setButton(button: childsCat)
    }
    @IBAction func selectedFarmingCat(_ sender: UIButton) {
        setButton(button: farmingCat)
    }
    @IBAction func selectedServicesCat(_ sender: UIButton) {
        setButton(button: servicesCat)
    }
    @IBAction func selectedColeccCat(_ sender: UIButton) {
        setButton(button: collectiblesCat)
    }
    @IBAction func selectBuildingCat(_ sender: UIButton) {
        setButton(button: constructionCat)
    }
    @IBAction func selectOthersCat(_ sender: UIButton) {
        setButton(button: othersCat)
    }
    
    func setButton(button: UIButton) {
        if button.isSelected == false {
            if counter < 4 {
                counter += 1
                button.isSelected = true
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                let banner = NotificationBanner(title: "Solo 4", subtitle: "No puedes seleccionar más de 4 categorías", style: .warning)
                banner.show()
            }
        } else {
            counter -= 1
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TutorialToHomeView" {
            if let homeVC = segue.destination as? HomeVC {
                homeVC.categoryList = self.categoryArray
                homeVC.categoryStringList = self.categoryStringArray
            }
        }
    }
    
    func setCategory(category: String) {
        switch category {
        case "Videojuegos":
            categoryInt = 1
        case "Hogar":
            categoryInt = 2
        case "Motor":
            categoryInt = 3
        case "Electrodomésticos":
            categoryInt = 4
        case "Moda":
            categoryInt = 5
        case "Jardín":
            categoryInt = 6
        case "TV":
            categoryInt = 7
        case "Música":
            categoryInt = 8
        case "Foto":
            categoryInt = 9
        case "Móviles":
            categoryInt = 10
        case "Informática":
            categoryInt = 11
        case "Deporte":
            categoryInt = 12
        case "Libros":
            categoryInt = 13
        case "Niños y bebés":
            categoryInt = 14
        case "Agricultura":
            categoryInt = 15
        case "Servicios":
            categoryInt = 16
        case "Coleccionismo":
            categoryInt = 17
        case "Construcción":
            categoryInt = 18
        case "Otros":
            categoryInt = 19
        default:
            categoryInt = 1
        }
    }
}
