//
//  EditProfileVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 30/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class EditProfileVC: BaseVC {

    @IBOutlet weak var editUserProfileImage: UIImageView!
    @IBOutlet weak var editUserImageButton: UIButton!
    
    @IBOutlet weak var userNameTitleLabel: UILabel!
    @IBOutlet weak var editUsernameTF: UITextField!
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var editNameTF: UITextField!
    
    @IBOutlet weak var surnameTitleLabel: UILabel!
    @IBOutlet weak var editSurnameTF: UITextField!
    
    @IBOutlet weak var passwordChangeButton: UIButton!
    @IBOutlet weak var privateProfileSwitch: UISwitch!
    
    @IBOutlet weak var birthdayChangeButton: UIButton!
    @IBOutlet weak var birthdayChangeDP: UIDatePicker!
    @IBOutlet weak var birthdaytextLabel: UILabel!
    @IBOutlet weak var dateBackground: UIView!
    @IBOutlet weak var birthdayChangeDoneButton: UIButton!
    
    @IBOutlet weak var editProfileSubmitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Editar Perfil"
        customSettings()
        
    }
    
    func customSettings() {
        //editUserProfileImage atributes
        editUserProfileImage.layer.cornerRadius = 90
        editUserProfileImage.layer.borderWidth = 8
        editUserProfileImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor
        
        //editUserImageButton atributes
        editUserImageButton.layer.cornerRadius = 25
        editUserImageButton.layer.borderWidth = 3
        editUserImageButton.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/225, alpha: 1).cgColor

        //editUsernameTF atributes
        editUsernameTF.layer.borderWidth = 1
        editUsernameTF.layer.cornerRadius = 5
        editUsernameTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        editUsernameTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        editUsernameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: editUsernameTF.frame.height))
        editUsernameTF.leftViewMode = .always
        editUsernameTF.text = Session.current.userModel?.username
        
        //editNameTF atributes
        editNameTF.layer.borderWidth = 1
        editNameTF.layer.cornerRadius = 5
        editNameTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        editNameTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        editNameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: editNameTF.frame.height))
        editNameTF.leftViewMode = .always
        editNameTF.text = Session.current.userModel?.name
        
        //editSurnameTF atributes
        editSurnameTF.layer.borderWidth = 1
        editSurnameTF.layer.cornerRadius = 5
        editSurnameTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        editSurnameTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        editSurnameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: editSurnameTF.frame.height))
        editSurnameTF.leftViewMode = .always
        editSurnameTF.text = Session.current.userModel?.lastName
        
        //formSubmitButton atributes
        editProfileSubmitButton.layer.cornerRadius = 20
        
        birthdaytextLabel.text = Session.current.userModel?.birthday
    }
    
    @IBAction func editBirthday(_ sender: Any) {
        dateBackground.layer.isHidden = false
        birthdayChangeDP.layer.isHidden = false
        birthdayChangeDoneButton.layer.isHidden = false
    }
    
    @IBAction func hideDatePickerView(_ sender: UIButton) {
        convertBirthday()
        dateBackground.layer.isHidden = true
        birthdayChangeDP.layer.isHidden = true
        birthdayChangeDoneButton.layer.isHidden = true
        
    }
    
    func convertBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let dateToString = dateFormatter.string(from: birthdayChangeDP.date)
        birthdaytextLabel.text = dateToString
    }
    

}
