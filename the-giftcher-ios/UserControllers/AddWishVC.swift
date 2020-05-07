//
//  AddWishVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 19/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class AddWishVC: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var dataInputView: UIView!
    @IBOutlet weak var dataInputSV: UIScrollView!
    
    @IBOutlet weak var wishNameTF: UITextField!
    @IBOutlet weak var wishShopTF: UITextField!
    @IBOutlet weak var wishLocationTF: UITextField!
    @IBOutlet weak var wishPriceTF: UITextField!
    @IBOutlet weak var wishDescriptionTV: UITextView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryPickerView: UIView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var associateButton: UIButton!
    
    var pickerData: [String] = [String]()
    let imagePickerContr = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Añadir deseo"
        customSettings()
        
        pickerData = ["Agricultura", "Coleccionismo", "Construcción", "Deporte", "Electrodomésticos", "Foto", "Hogar", "Informática", "Jardín", "Libros", "Moda", "Motor", "Móviles", "Música", "Niños y Bebés", "Otros", "Servicios", "TV", "Videojuegos"]
        
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        imagePickerContr.delegate = self
        
    }
    
    func customSettings() {
        //imagePicker atributes
        imagePicker.layer.cornerRadius = 2
        imagePicker.layer.borderWidth = 3
        imagePicker.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        imagePicker.layer.shadowColor = UIColor.black.cgColor
        imagePicker.layer.shadowOffset = CGSize(width:0.0, height:2.0)
        imagePicker.layer.masksToBounds = false
        imagePicker.layer.shadowRadius = 2.0
        imagePicker.layer.shadowOpacity = 0.6
        
        //wishNameTF atributes
        wishNameTF.layer.borderWidth = 1
        wishNameTF.layer.cornerRadius = 5
        wishNameTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        wishNameTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        wishNameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: wishNameTF.frame.height))
        wishNameTF.leftViewMode = .always
        
        //wishShopTF atributes
        wishShopTF.layer.borderWidth = 1
        wishShopTF.layer.cornerRadius = 5
        wishShopTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        wishShopTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        wishShopTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: wishShopTF.frame.height))
        wishShopTF.leftViewMode = .always
        
        //wishLocationTF atributes
        wishLocationTF.layer.borderWidth = 1
        wishLocationTF.layer.cornerRadius = 5
        wishLocationTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        wishLocationTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        wishLocationTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: wishLocationTF.frame.height))
        wishLocationTF.leftViewMode = .always
        
        //wishPriceTF atributes
        wishPriceTF.layer.borderWidth = 1
        wishPriceTF.layer.cornerRadius = 5
        wishPriceTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        wishPriceTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        wishPriceTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: wishPriceTF.frame.height))
        wishPriceTF.leftViewMode = .always
        
        //wishDescriptionTV atributes
        wishDescriptionTV.layer.borderWidth = 1
        wishDescriptionTV.layer.cornerRadius = 5
        wishDescriptionTV.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        wishDescriptionTV.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        
        //saveButton atributes
        saveButton.layer.cornerRadius = 20
        
        //associateButton atributes
        associateButton.layer.cornerRadius = 20
        
        //dataInputView atributes
        dataInputView.layer.cornerRadius = 5
        
        //dataInputSV atributes
        dataInputSV.layer.cornerRadius = 5
        dataInputSV.layer.shadowColor = UIColor.black.cgColor
        dataInputSV.layer.shadowOffset = CGSize(width:0.0, height:2.0)
        dataInputSV.layer.masksToBounds = false
        dataInputSV.layer.shadowRadius = 2.0
        dataInputSV.layer.shadowOpacity = 0.6
        
        wishNameTF.delegate = self
        wishShopTF.delegate = self
        wishLocationTF.delegate = self
        wishPriceTF.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categorySelected = pickerData[row] as String
        categoryNameLabel.text = categorySelected
    }
    @IBAction func setCategory(_ sender: Any) {
        categoryPickerView.layer.isHidden = false
        categoryPicker.layer.isHidden = false
        doneButton.layer.isHidden = false
    }
    @IBAction func hidePicker(_ sender: Any) {
        categoryPickerView.layer.isHidden = true
        categoryPicker.layer.isHidden = true
        doneButton.layer.isHidden = true
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePickerContr.allowsEditing = false
        imagePickerContr.sourceType = .photoLibrary
        
        present(imagePickerContr, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicker.contentMode = .scaleToFill
            imagePicker.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
