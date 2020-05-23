//
//  EditWishVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 16/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class EditWishVC: BaseVC, NVActivityIndicatorViewable, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    var pickerData: [String] = [String]()
    let imagePickerContr = UIImagePickerController()
    var categoryInt = Int()
    var wish: WishModel?
    var categoryString: String?
    var imagePicker: ImagePicker!
    
    //Outlets
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var setImageButton: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var shopInput: UITextField!
    @IBOutlet weak var onlineShopInput: UITextField!
    @IBOutlet weak var priceInput: UITextField!
    @IBOutlet weak var chooseCategoryButton: UIButton!
    @IBOutlet weak var descriptionButton: UITextView!
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var pickerButton: UIPickerView!
    @IBOutlet weak var doneChoosingButton: UIButton!
    @IBOutlet weak var saveWishButton: UIButton!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dataInput: UIView!
    @IBOutlet weak var dataInputSV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Editar"
        customSettings()
        
        pickerData = ["Agricultura", "Coleccionismo", "Construcción", "Deporte", "Electrodomésticos", "Foto", "Hogar", "Informática", "Jardín", "Libros", "Moda", "Motor", "Móviles", "Música", "Niños y Bebés", "Otros", "Servicios", "TV", "Videojuegos"]
        
        self.pickerButton.delegate = self
        self.pickerButton.dataSource = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func customSettings() {
        wishImage.layer.cornerRadius = 2
        wishImage.layer.borderWidth = 3
        wishImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        wishImage.layer.shadowColor = UIColor.black.cgColor
        wishImage.layer.shadowOffset = CGSize(width:0.0, height:2.0)
        wishImage.layer.masksToBounds = false
        wishImage.layer.shadowRadius = 2.0
        wishImage.layer.shadowOpacity = 0.6
        
        //nameInput atributes
        nameInput.layer.borderWidth = 1
        nameInput.layer.cornerRadius = 5
        nameInput.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        nameInput.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        nameInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameInput.frame.height))
        nameInput.leftViewMode = .always
        nameInput.text = wish?.name ?? ""
        
        //shopInput atributes
        shopInput.layer.borderWidth = 1
        shopInput.layer.cornerRadius = 5
        shopInput.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        shopInput.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        shopInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: shopInput.frame.height))
        shopInput.leftViewMode = .always
        shopInput.text = wish?.shop ?? ""
        
        //onlineShopInput atributes
        onlineShopInput.layer.borderWidth = 1
        onlineShopInput.layer.cornerRadius = 5
        onlineShopInput.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        onlineShopInput.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        onlineShopInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: onlineShopInput.frame.height))
        onlineShopInput.leftViewMode = .always
        onlineShopInput.text = wish?.onlineShop ?? ""
        
        //priceInput atributes
        priceInput.layer.borderWidth = 1
        priceInput.layer.cornerRadius = 5
        priceInput.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        priceInput.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        priceInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: priceInput.frame.height))
        priceInput.leftViewMode = .always
        priceInput.text = wish?.price?.description ?? ""
        
        //descriptionButton atributes
        descriptionButton.layer.borderWidth = 1
        descriptionButton.layer.cornerRadius = 5
        descriptionButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        descriptionButton.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        descriptionButton.text = wish?.description ?? ""
        
        //saveButton atributes
        saveWishButton.layer.cornerRadius = 20
        
        //dataInputView atributes
        dataInput.layer.cornerRadius = 5
        
        //dataInputSV atributes
        dataInputSV.layer.cornerRadius = 5
        dataInputSV.layer.shadowColor = UIColor.black.cgColor
        dataInputSV.layer.shadowOffset = CGSize(width:0.0, height:2.0)
        dataInputSV.layer.masksToBounds = false
        dataInputSV.layer.shadowRadius = 2.0
        dataInputSV.layer.shadowOpacity = 0.6
        
        setCategoryFromInt(category: wish?.category ?? 0)
        categoryNameLabel.text = categoryString
        
        nameInput.delegate = self
        shopInput.delegate = self
        onlineShopInput.delegate = self
        priceInput.delegate = self
        
    }
    
    @IBAction func doSetWishImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    
    @IBAction func doneChoosingCategory(_ sender: Any) {
        pickerButton.isHidden = true
        pickerViewContainer.isHidden = true
        doneChoosingButton.isHidden = true
    }
    
    @IBAction func saveWish(_ sender: Any) {
        saveWishButton.bounce()
        if nameInput.text == "" || shopInput.text == "" || onlineShopInput.text == "" || priceInput.text == "" || descriptionButton.text == "" || categoryNameLabel.text == "" {
            
            let banner = NotificationBanner(title: "Error", subtitle: "Debes rellenar todos los campos", style: .warning)
            banner.show()
            
        } else {
            
            let priceText = priceInput.text
            let priceFloat = (priceText! as NSString).floatValue
            let reserveStatus = false
            let locationDefault = ""
            setCategory(category: categoryNameLabel.text ?? "Otros")
            let imagePathDef = wish?.imagePath ?? ""
            let imageName = wish?.imageName ?? ""
            
            
            let inputWish = InputWish(name: nameInput.text, description: descriptionButton.text, price: priceFloat, shop: shopInput.text, imageName: imageName, imagePath: imagePathDef, reserved: reserveStatus, location: locationDefault, onlineShop: onlineShopInput.text, category: categoryInt)
            doEditWishRequest(inputWish: inputWish)
            
        }
    }
    
    func doEditWishRequest(inputWish: InputWish) {
        print("Do edit Wish Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.wishModifyRequest(idWish: wish?.id!,inputWish: inputWish) {
            success, result, error in
            if let result = result as? WishModel {
                
                self.sendWishImageRequest(id: result.id!)
                let banner = NotificationBanner(title: "Deseo Modificado", subtitle: "El deseo ha sido modificado correctamente", style: .info)
                banner.show()
                
                self.navigationController?.popViewController(animated: true)
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                NotificationCenter.default.post(name: .didEditWishRequest, object: nil)
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    @IBAction func openCategoryPicker(_ sender: Any) {
        pickerButton.isHidden = false
        pickerViewContainer.isHidden = false
        doneChoosingButton.isHidden = false
    }
    
    //MARK:: PICKERVIEW DELEGATES
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categorySelected = pickerData[row]
        categoryNameLabel.text = categorySelected
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
    
    func setCategoryFromInt(category: Int) {
        switch category {
        case 1:
            categoryString = "Videojuegos"
        case 2:
            categoryString = "Hogar"
        case 3:
            categoryString = "Motor"
        case 4:
            categoryString = "Electrodomésticos"
        case 5:
            categoryString = "Moda"
        case 6:
            categoryString = "Jardín"
        case 7:
            categoryString = "TV"
        case 8:
            categoryString = "Música"
        case 9:
            categoryString = "Foto"
        case 10:
            categoryString = "Móviles"
        case 11:
            categoryString = "Informática"
        case 12:
            categoryString = "Deporte"
        case 13:
            categoryString = "Libros"
        case 14:
            categoryString = "Niños y bebés"
        case 15:
            categoryString = "Agricultura"
        case 16:
            categoryString = "Servicios"
        case 17:
            categoryString = "Coleccionismo"
        case 18:
            categoryString = "Construcción"
        default:
            categoryString = "Otros"
        }
    }
    
    func sendWishImageRequest(id: Int) {
           print("Uploading image")
           let profilePicture = wishImage.image
           let image = profilePicture ?? UIImage(named: "placeholder")
           dataMapper.addWishImageRequest(wishId: id, image: image!) {
               success, result, error in
               if let result = result as? WishModel {
                   print("Wish Image Path => \(result.imagePath ?? "NO HAY USUARIO")")
               }
           }
       }
    
}

extension EditWishVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.wishImage.image = image
    }
}
