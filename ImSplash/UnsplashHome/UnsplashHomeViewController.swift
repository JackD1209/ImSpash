//
//  UnsplashHomeViewController.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import UIKit
import Kingfisher

class UnsplashHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var photoThumbSize: CGFloat = 0
    private var photos: [Photo] = []
    private var currentPage: Int = 1
    private var isWating: Bool = false
    
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
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.backgroundColor = .clear
        photoThumbSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    }
    
    private func loadData() {
        isWating = true
        UnsplashHomeAPI.fetchPhotos(page: currentPage, width: Int(photoThumbSize), callback: { [weak self] photos, error in
            guard let self = self else { return }
            guard error == nil else { return }
            
            self.photos.append(contentsOf: photos)
            self.isWating = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CollectionsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CollectionsViewController") as! CollectionsViewController
        vc.photos = photos
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension UnsplashHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsplashHomeCollectionViewCell", for: indexPath) as! UnsplashHomeCollectionViewCell
        cell.setupCell(photo: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoThumbSize, height: photoThumbSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PhotoViewStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PhotoViewViewController") as! PhotoViewViewController
        vc.photo = photos[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.height {
//            if !isWating {
//                currentPage += 1
//                loadData()
//            }
//        }
//    }
}

extension UnsplashHomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return photos[indexPath.row].photoHeight
    }
}
