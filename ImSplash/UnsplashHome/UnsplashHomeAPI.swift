//
//  UnsplashHomeAPI.swift
//  ImSplash
//
//  Created by Doan Minh Hoang on 4/21/20.
//  Copyright © 2020 Doan Minh Hoang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

class UnsplashHomeAPI {
    
    static var photoWidth: Int = 0
    
    static func fetchPhotos(page: Int, width: Int, callback: @escaping ([Photo], Error?) -> ()) {
        photoWidth = width
        let url = APIConstants.BASE_URL + "photos"
        let parameters: Parameters = [
            "w": width,
            "page": page
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: APIConstants.HEADER).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photos = parsePhotos(json: json)
                callback(photos, nil)
            case .failure(let error):
                callback([], error)
            }
        }
    }
    
    static private func parsePhotos(json: JSON) -> [Photo] {
        var photos: [Photo] = []
        let jsonPhotos = json.arrayValue
        
        for jsonPhoto in jsonPhotos {
            let photo = Photo()
            
            photo.id = jsonPhoto["id"].stringValue
            photo.photoHeight = CGFloat(jsonPhoto["height"].intValue * photoWidth / jsonPhoto["width"].intValue)
            photo.profileName = jsonPhoto["user"]["name"].stringValue
            photo.profileUsername = jsonPhoto["user"]["username"].stringValue
            photo.profileImage = jsonPhoto["user"]["profile_image"]["small"].stringValue
            photo.photoURLThumb = jsonPhoto["urls"]["raw"].stringValue
            photo.photoURLFull = jsonPhoto["urls"]["full"].stringValue
            photo.photoURLRegular = jsonPhoto["urls"]["regular"].stringValue
                        
            photos.append(photo)
        }
        
        return photos
    }
}
