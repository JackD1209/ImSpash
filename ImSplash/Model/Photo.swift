//
//  Photo.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import Foundation
import UIKit

class Photo: NSObject, NSCoding {
    
    var id: String = ""
    var photoHeight: CGFloat = 0
    var profileName: String = ""
    var profileUsername: String = ""
    var profileImage: String = ""
    var photoURLThumb: String = ""
    var photoURLFull: String = ""
    var photoURLRegular: String = ""
    var photoImage: UIImage = UIImage()
    var isFavorite: Bool = false
    var isLocal: Bool = false
    var isDownloading: Bool = false
    var downloadProgress: String = ""
    
    override init() {
    }
    
    required init(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as! String
        photoHeight = coder.decodeObject(forKey: "photoHeight") as! CGFloat
        profileName = coder.decodeObject(forKey: "profileName") as! String
        profileUsername = coder.decodeObject(forKey: "profileUsername") as! String
        profileImage = coder.decodeObject(forKey: "profileImage") as! String
        photoURLThumb = coder.decodeObject(forKey: "photoURLThumb") as! String
        photoURLFull = coder.decodeObject(forKey: "photoURLFull") as! String
        photoURLRegular = coder.decodeObject(forKey: "photoURLRegular") as! String
        photoImage = coder.decodeObject(forKey: "photoImage") as! UIImage
        isFavorite = coder.decodeBool(forKey: "isFavorite")
        isLocal = coder.decodeBool(forKey: "isLocal")
        isDownloading = coder.decodeBool(forKey: "isDownloading")
        downloadProgress = coder.decodeObject(forKey: "downloadProgress") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(photoHeight, forKey: "photoHeight")
        coder.encode(profileName, forKey: "profileName")
        coder.encode(profileUsername, forKey: "profileUsername")
        coder.encode(profileImage, forKey: "profileImage")
        coder.encode(photoURLThumb, forKey: "photoURLThumb")
        coder.encode(photoURLFull, forKey: "photoURLFull")
        coder.encode(photoURLRegular, forKey: "photoURLRegular")
        coder.encode(photoImage, forKey: "photoImage")
        coder.encode(isFavorite, forKey: "isFavorite")
        coder.encode(isLocal, forKey: "isLocal")
        coder.encode(isDownloading, forKey: "isDownloading")
        coder.encode(downloadProgress, forKey: "downloadProgress")
    }
}
