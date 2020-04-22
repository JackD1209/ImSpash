//
//  PhotoViewViewController.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewViewController: UIViewController, URLSessionDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
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
        favoriteImageView.image = photo.isFavorite ? UIImage(named: "favorite_icon_filled") : UIImage(named: "favorite_icon")
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
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        if favoriteImageView.image == UIImage(named: "favorite_icon") {
            favoriteImageView.image = UIImage(named: "favorite_icon_filled")
            photo.isFavorite = true
        } else {
            favoriteImageView.image = UIImage(named: "favorite_icon")
            photo.isFavorite = false
        }
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        if let url = URL(string: photo.photoURLFull) {
            if let _ = Utilities.getFileLocalPathByUrl(fileUrl: url) {
                let alert = UIAlertController.init(title: "Download Image", message: "The file already downloaded", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            let downloadTask = session.downloadTask(with: url)
            photo.isDownloading = true
            downloadTask.resume()
        }
    }
}

extension PhotoViewViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        photo.isDownloading = false
        let url = downloadTask.originalRequest!.url

        if let data = NSData(contentsOf: location) {
            Utilities.storeFileLocally(photo: photo, remoteFileUrl: url!, data: data)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100
        photo.downloadProgress = "\(Int(progress))%"
    }
}
