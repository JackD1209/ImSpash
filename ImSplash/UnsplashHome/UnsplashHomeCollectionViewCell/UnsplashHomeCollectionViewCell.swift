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
        Utilities.loadImage(url: photo.photoURLThumb, imageView: imageView, id: "\(photo.id)+Thumb")
        imageView.roundCorner()
        layoutIfNeeded()
    }
}
