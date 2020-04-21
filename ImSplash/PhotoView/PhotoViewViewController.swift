//
//  PhotoViewViewController.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func loadUI() {
        favouriteImageView.image = photo.isFavourite ? UIImage(named: "favourite_icon_filled") : UIImage(named: "favourite_icon")
    }
    
    private func loadData() {
        guard photo != nil else { return }
        
        Utilities.loadImage(url: photo.profileImage, imageView: profileImageView, id: "\(photo.id)+Profile")
        profileImageView.circleView()
        profileNameLabel.text = photo.profileName
        profileUsernameLabel.text = "@\(photo.profileUsername)"
        
        Utilities.loadImage(url: photo.photoURLRegular, imageView: imageView, id: "\(photo.id)+Regular")
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
    }
}
