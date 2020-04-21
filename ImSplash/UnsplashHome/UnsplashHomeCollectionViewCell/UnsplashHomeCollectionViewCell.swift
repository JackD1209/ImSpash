//
//  UnsplashHomeCollectionViewCell.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import UIKit
import Kingfisher

class UnsplashHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func setupCell(photo: Photo) {
        if let imageURL = URL(string: photo.photoURLThumb) {
            var imageResource = ImageResource(downloadURL: imageURL)
            imageResource = ImageResource(downloadURL: imageURL, cacheKey: photo.id)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageResource)
        }
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        layoutIfNeeded()
    }
}
