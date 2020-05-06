//
//  ImageView+Url.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 06/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadUrl(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping () -> Void = {}) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
                completion()
            }
        }.resume()
    }
    
    func loadUrl(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping () -> Void = {}) {
        guard let url = URL(string: link) else { return }
        loadUrl(from: url, contentMode: mode, completion: completion)
    }
}
