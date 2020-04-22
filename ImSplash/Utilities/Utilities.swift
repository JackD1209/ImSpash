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
    
    static func getFileLocalPathByUrl(fileUrl: URL) -> URL? {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentsUrl!.appendingPathComponent(fileUrl.lastPathComponent)
            
        if FileManager().fileExists(atPath: destinationUrl.path) {
            return destinationUrl
        }
      
        return nil
    }
    
    static func storeFileLocally(photo: Photo, remoteFileUrl: URL, data: NSData?) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentsUrl!.appendingPathComponent(remoteFileUrl.lastPathComponent)
            
        if let data = data {
            if data.write(to: destinationUrl, atomically: true) {
                updateLocalImages(photo: photo)
            }
        }
    }
    
    static func updateLocalImages(photo: Photo) {
        let data = UserDefaults.standard.object(forKey: "localImages") as? NSData
        do {
            var finalArray = data != nil ? try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data! as Data) as? [Photo] : [Photo]()
            if let index = finalArray!.firstIndex(where: { $0.id == photo.id }) {
                finalArray![index] = photo
            } else {
                photo.isLocal = true
                finalArray!.append(photo)
            }
            let savedArray = try? NSKeyedArchiver.archivedData(withRootObject: finalArray!, requiringSecureCoding: false) as NSData
            UserDefaults.standard.set(savedArray, forKey: "localImages")
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

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
