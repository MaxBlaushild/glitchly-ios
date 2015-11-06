//
//  PictureProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PictureAPIController: ProtectedAPIController {
    
    func getPicture(pictureId: Int) {
        
        let url = apiURL + "/pictures/\(pictureId)"
        
        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { request, response, result in
                
                let json = JSON(result.value!)
                
                let jsonPicture:JSON = json["picture"]

                let picture = Picture(json: jsonPicture)
                
                NSNotificationCenter.defaultCenter().postNotificationName("pictureFetched", object: picture)
                
        }
        
    }
}
