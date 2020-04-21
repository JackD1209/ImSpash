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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    private var photo: Photo!
    
    func setupCell(photo: Photo) {
        Utilities.loadImage(url: photo.photoURLThumb, imageView: imageView, id: "\(photo.id)+Thumb")
        imageView.roundCorner()
        layoutIfNeeded()
    }
    
    func setupCellForDownload(photo: Photo) {
        self.photo = photo
        Utilities.loadImage(url: photo.photoURLThumb, imageView: imageView, id: "\(photo.id)+Thumb")
        
        favouriteImageView.image = photo.isFavourite ? UIImage(named: "favourite_icon_filled") : UIImage(named: "favourite_icon")
        containerView.roundCorner()
        layoutIfNeeded()
    }
    
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        if favouriteImageView.image == UIImage(named: "favourite_icon") {
            favouriteImageView.image = UIImage(named: "favourite_icon_filled")
            photo.isFavourite = true
        } else {
            favouriteImageView.image = UIImage(named: "favourite_icon")
            photo.isFavourite = false
        }
    }
}
