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
    
//    "id": "LBI7cgq3pbM",
//    "width": 5245,
//    "height": 3497,
//    "user": {
//      "id": "pXhwzz1JtQU",
//      "username": "poorkane",
//      "name": "Gilbert Kane",
//      "portfolio_url": "https://theylooklikeeggsorsomething.com/",
//      "bio": "XO",
//      "location": "Way out there",
//      "total_likes": 5,
//      "total_photos": 74,
//      "total_collections": 52,
//      "instagram_username": "instantgrammer",
//      "twitter_username": "crew",
//      "profile_image": {
//        "small": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=32&w=32",
//        "medium": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=64&w=64",
//        "large": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128"
//      }
//    }
//    "urls": {
//      "raw": "https://images.unsplash.com/face-springmorning.jpg",
//      "full": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg",
//      "regular": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=1080&fit=max",
//      "small": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
//      "thumb": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=200&fit=max"
//    },
//    "links": {
//      "self": "https://api.unsplash.com/photos/LBI7cgq3pbM",
//      "html": "https://unsplash.com/photos/LBI7cgq3pbM",
//      "download": "https://unsplash.com/photos/LBI7cgq3pbM/download",
//      "download_location": "https://api.unsplash.com/photos/LBI7cgq3pbM/download"
//    }
}
