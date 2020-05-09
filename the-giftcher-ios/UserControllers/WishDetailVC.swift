//
//  WishDetailVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class WishDetailVC: ViewController, NVActivityIndicatorViewable {
    
    var wish: WishModel?
    var categoryString: String?
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    let dataMapper = DataMapper()
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uiViewsOutlet: UIView!
    @IBOutlet weak var uiViews2Outlet: UIView!
    @IBOutlet weak var uiViews3Outlet: UIView!
    @IBOutlet weak var shareButtonView: UIView!
    @IBOutlet weak var buttonSaveView: UIView!
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var wishPrice: UILabel!
    @IBOutlet weak var wishDescription: UILabel!
    @IBOutlet weak var wishCategory: UILabel!
    @IBOutlet weak var wishStore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title =  "Detalle de Deseo"
        setModifiers()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title =  "Detalle de Deseo"
    }
    
    
    func setModifiers(){
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 0.5
        
        uiViewsOutlet.layer.borderColor = UIColor.red.cgColor
        uiViewsOutlet.layer.borderWidth = 0.5
        
        uiViews2Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews2Outlet.layer.borderWidth = 0.5
        
        uiViews3Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews3Outlet.layer.borderWidth = 0.5
        
    }
    
    func loadData() {
        wishName.text = wish?.name
        wishPrice.text = "\(String(describing: wish?.price ?? 0))€"
        wishDescription.text = wish?.description
        setCategory(category: wish?.category ?? 0)
        wishCategory.text = categoryString
        wishStore.text = wish?.shop
        
        if let avatar = wish?.imagePath {
            imageView.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
    }
    
    @IBAction func saveWish(_ sender: UIButton) {
        saveWishFromOtherUser()
    }
    
    @IBAction func shareWish(_ sender: Any) {
        let firstActivityItem = "Regalame esto: \(wishName.text!)"
        let image : UIImage = imageView.image!
        let secondActivityItem : NSURL = NSURL(string: "http://www.thegiftcher.com")!
       

        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func saveWishFromOtherUser() {
        print("Do copy wish from another user")
        
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.copyWishFromUserRequest(userId: wish?.userId.unsafelyUnwrapped, idWish: wish?.id.unsafelyUnwrapped) {
            success, result, error in
            if let result = result as? WishModel {
                if result.userId == Session.current.id {
                    let banner = NotificationBanner(title: "Deseo Guardado", subtitle: "Nuevo deseo guardado en tu lista de deseos", style: .info)
                    banner.show()
                }
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    func setCategory(category: Int) {
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
    
}
