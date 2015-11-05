//
//  FollowManager.swift
//  glitchly
//
//  Created by Max Blaushild on 10/28/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith

class FollowAPIController: APIController {

    func followUser(user_id: Int){
        
        let URL =  apiURL + "/users/\(user_id)/follow"
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
                NSNotificationCenter.defaultCenter().postNotificationName("followStatusToggled", object: nil)
        }
        
        
    }
    
    func unfollowUser(user_id: Int){

        let URL =  apiURL + "/users/\(user_id)/unfollow"
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
              NSNotificationCenter.defaultCenter().postNotificationName("followStatusToggled", object: nil)  
        }
        
        
    }

}
