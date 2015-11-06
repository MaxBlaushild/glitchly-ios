//
//  LikeManager.swift
//  glitchly
//
//  Created by Max Blaushild on 10/23/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith


class LikeAPIController: ProtectedAPIController {
    
    func likePicture(picture_id: Int){
            
        let like = [
            "like": [
            ]
        ]
        
        let URL =  apiURL + "/pictures/\(picture_id)/likes"
        
        Alamofire.request(.POST, URL, parameters: like, headers: headers)
            .responseJSON { request, response, result in
                
                
        }
        
    }
    
    func unlikePicture(picture_id: Int){
        
        let URL = apiURL + "/pictures/\(picture_id)/likes"
        
        Alamofire.request(.DELETE, URL, headers: headers)
            .responseJSON { request, response, result in
                
                
        }
    }
        

}
