//
//  FeedProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Locksmith

class FeedProvider: NSObject {
    
    private let pictureSerializer = PictureSerializer()
    
    func getFeed() {
        let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount")!
        if let token:String = user["token"] as? String {
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38"
            
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    let json = JSON(result.value!)
                    let jsonPictures:[JSON] = json["pictures"].array! as [JSON]
                    
                    var pictures = [Picture]()
                    for picture in jsonPictures {
                        let newPic = self.pictureSerializer.serializePicture(picture)
                        pictures.append(newPic)
                    }
                    
                NSNotificationCenter.defaultCenter().postNotificationName("feedFetched", object: pictures)
                    
                }
            
            }

        }
        
}
