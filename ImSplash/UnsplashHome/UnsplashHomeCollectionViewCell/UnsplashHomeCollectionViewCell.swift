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
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    private var photo: Photo!
    
    func setupCell(photo: Photo) {
        Utilities.loadImage(url: photo.photoURLThumb, imageView: imageView, id: "\(photo.id)+Thumb")
        imageView.roundCorner()
        layoutIfNeeded()
    }
    
    func setupCellForDownload(photo: Photo) {
        self.photo = photo
        if photo.isLocal {
            getImageFromDirectory(fileName: photo.photoURLFull)
        } else {
            Utilities.loadImage(url: photo.photoURLThumb, imageView: imageView, id: "\(photo.id)+Thumb")
        }
        
        favoriteImageView.image = photo.isFavorite ? UIImage(named: "favorite_icon_filled") : UIImage(named: "favorite_icon")
        if photo.isDownloading {
            downloadView.isHidden = false
            downloadLabel.text = photo.downloadProgress
        } else {
            downloadView.isHidden = true
        }
        
        containerView.roundCorner()
        layoutIfNeeded()
    }
    
    func getImageFromDirectory(fileName: String) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = URL(string: fileName)
        let fileURL = documentsUrl!.appendingPathComponent(url!.lastPathComponent)
        var imageData : Data?
        do {
            imageData = try Data(contentsOf: fileURL)
            imageView.image = UIImage(data: imageData ?? Data())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        if favoriteImageView.image == UIImage(named: "favorite_icon") {
            favoriteImageView.image = UIImage(named: "favorite_icon_filled")
            photo.isFavorite = true
        } else {
            favoriteImageView.image = UIImage(named: "favorite_icon")
            photo.isFavorite = false
        }
        
        if photo.isLocal {
            Utilities.updateLocalImages(photo: photo)
        }
    }
}
