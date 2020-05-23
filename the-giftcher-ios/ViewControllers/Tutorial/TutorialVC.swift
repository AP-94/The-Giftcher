//
//  TutorialVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 23/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var goToPrefsButton: UIButton!
    var contentWidth:CGFloat = 0.0
    var pendingPage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        customSettings()
    }
    
    func customSettings() {
        goToPrefsButton.layer.cornerRadius = 10
        
        for image in 0...6{
            let imageToDisplay = UIImage(named: "\(image).png")
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate - 150 , y: (view.frame.height / 2) - 310 , width: 300, height: 600)
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.height)
    }
    
    @IBAction func goToPrefs(_ sender: Any) {
        goToPrefsButton.bounce()
        performSegue(withIdentifier: "tutorialToChooseVC", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          print(scrollView.contentOffset)
          pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(375))
          
          if (scrollView.contentOffset.x >= 2250){
              //enable button to like choose
          }
          
      }
}
