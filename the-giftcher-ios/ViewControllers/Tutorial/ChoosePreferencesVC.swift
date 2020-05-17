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
    
    var selectionStatus = false
    var categoryInt: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        customSettings()
        maxCatSelected()

    }
    
    func customSettings() {
        videogamesCat.whiteAndRedRounded()
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if selectionStatus == true {
            self.performSegue(withIdentifier: "TutorialToHomeView", sender: nil)
        }
    }
    
    @IBAction func selectedVideoGameCat(_ sender: Any) {
        videogamesCat.whiteAndRedRoundedSelected()
        setCategory(category: videogamesCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    
    @IBAction func selectedHomeCat(_ sender: Any) {
        homeCat.whiteAndRedRoundedSelected()
        setCategory(category: homeCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedMotorCat(_ sender: Any) {
        motorCat.whiteAndRedRoundedSelected()
        setCategory(category: motorCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedHomeApliCat(_ sender: Any) {
        homeAppliancesCat.whiteAndRedRoundedSelected()
        setCategory(category: homeAppliancesCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedFashionCat(_ sender: Any) {
        fashionCat.whiteAndRedRoundedSelected()
        setCategory(category: fashionCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedGardenCat(_ sender: Any) {
        gardenCat.whiteAndRedRoundedSelected()
        setCategory(category: gardenCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedTVCat(_ sender: Any) {
        televisionCat.whiteAndRedRoundedSelected()
        setCategory(category: televisionCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedMusicCat(_ sender: Any) {
        musicCat.whiteAndRedRoundedSelected()
        setCategory(category: musicCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedFotoCat(_ sender: Any) {
        photoCat.whiteAndRedRoundedSelected()
        setCategory(category: photoCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedCellPhoneCat(_ sender: Any) {
        cellphoneCat.whiteAndRedRoundedSelected()
        setCategory(category: cellphoneCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedInformaticCat(_ sender: Any) {
        informaticCat.whiteAndRedRoundedSelected()
        setCategory(category: informaticCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedSportsCat(_ sender: Any) {
        sportsCat.whiteAndRedRoundedSelected()
        setCategory(category: sportsCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedBooksCat(_ sender: Any) {
        bookCat.whiteAndRedRoundedSelected()
        setCategory(category: bookCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedChildCat(_ sender: Any) {
        childsCat.whiteAndRedRoundedSelected()
        setCategory(category: childsCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedFarmingCat(_ sender: Any) {
        farmingCat.whiteAndRedRoundedSelected()
        setCategory(category: farmingCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedServicesCat(_ sender: Any) {
        servicesCat.whiteAndRedRoundedSelected()
        setCategory(category: servicesCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectedColeccCat(_ sender: Any) {
        collectiblesCat.whiteAndRedRoundedSelected()
        setCategory(category: collectiblesCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectBuildingCat(_ sender: Any) {
        constructionCat.whiteAndRedRoundedSelected()
        setCategory(category: constructionCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    @IBAction func selectOthersCat(_ sender: Any) {
        othersCat.whiteAndRedRoundedSelected()
        setCategory(category: othersCat.titleLabel?.text ?? "")
        categoryInt.append(contentsOf: categoryInt)
    }
    func maxCatSelected() {
        if categoryInt.count >= 4 {
            let banner = NotificationBanner(title: "Error", subtitle: "No puedes seleccionar más de 4 categorías", style: .warning)
            banner.show()
            selectionStatus = false
        } else if categoryInt.count <= 3 {
            let banner = NotificationBanner(title: "Éxito", subtitle: "Ya puedes pasar a la siguiente pantalla", style: .success)
            banner.show()
            selectionStatus = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let catListPass = segue.destination as! HomeVC
        catListPass.categoryList = self.categoryInt
    }
    
    func setCategory(category: String) {
        switch category {
        case "Videojuegos":
            categoryInt = [1]
        case "Hogar":
            categoryInt = [2]
        case "Motor":
            categoryInt = [3]
        case "Electrodomésticos":
            categoryInt = [4]
        case "Moda":
            categoryInt = [5]
        case "Jardín":
            categoryInt = [6]
        case "TV":
            categoryInt = [7]
        case "Música":
            categoryInt = [8]
        case "Foto":
            categoryInt = [9]
        case "Móviles":
            categoryInt = [10]
        case "Informática":
            categoryInt = [11]
        case "Deporte":
            categoryInt = [12]
        case "Libros":
            categoryInt = [13]
        case "Niños y bebés":
            categoryInt = [14]
        case "Agricultura":
            categoryInt = [15]
        case "Servicios":
            categoryInt = [16]
        case "Coleccionismo":
            categoryInt = [17]
        case "Construcción":
            categoryInt = [18]
        case "Otros":
            categoryInt = [19]
        default:
            categoryInt = [1]
        }
    }
}
