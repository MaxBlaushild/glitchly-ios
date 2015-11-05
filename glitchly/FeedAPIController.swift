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

class FeedAPIController: APIController {
    
    func getFeed() {
            
        Alamofire.request(.GET, apiURL, headers: headers)
            .responseJSON { request, response, result in
                
                let json = JSON(result.value!)
                
                let jsonPictures:[JSON] = json["pictures"].array! as [JSON]
                
                var pictures = [Picture]()
                
                for picture in jsonPictures {
                    
                    pictures.append(Picture(json: picture))
                    
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName("feedFetched", object: pictures)
                
            }
        
        }

        
}
