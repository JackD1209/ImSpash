//
//  CollectionsViewController.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    private var photoThumbSize: CGFloat = 0
    var photos: [Photo] = []
    private var filtedPhotos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        collectionView.reloadData()
    }
    
    private func loadUI() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.backgroundColor = .clear
        photoThumbSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    }
    
    private func loadData() {
        filtedPhotos = photos
        collectionView.reloadData()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        favouriteButton.setTitleColor(.black, for: .normal)
        downloadButton.setTitleColor(UIColor(hexString: "E12C1C"), for: .normal)
        filtedPhotos = photos
        collectionView.reloadData()
    }
    
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        favouriteButton.setTitleColor(UIColor(hexString: "E12C1C"), for: .normal)
        downloadButton.setTitleColor(.black, for: .normal)
        filtedPhotos = photos.filter { $0.isFavourite }
        collectionView.reloadData()
    }
}

extension CollectionsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsplashHomeCollectionViewCell", for: indexPath) as! UnsplashHomeCollectionViewCell
        cell.setupCellForDownload(photo: filtedPhotos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoThumbSize, height: photoThumbSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PhotoViewStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PhotoViewViewController") as! PhotoViewViewController
        vc.photo = filtedPhotos[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension CollectionsViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return filtedPhotos[indexPath.row].photoHeight
    }
}
