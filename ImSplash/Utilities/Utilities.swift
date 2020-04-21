//
//  Utilities.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct Utilities {
    
    static func loadImage(url: String, imageView: UIImageView, id: String) {
        if let imageURL = URL(string: url) {
            var imageResource = ImageResource(downloadURL: imageURL)
            imageResource = ImageResource(downloadURL: imageURL, cacheKey: id)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageResource)
        }
    }
}

extension UIView {
    func roundCorner() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func circleView() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
}
