//
//  ProfileProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 10/20/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Locksmith


class ProfileAPIController: ProtectedAPIController {
    
    private let followAPIController:FollowAPIController = FollowAPIController()
    
    func getUserProfile(user_id: Int){

        let URL =  apiURL + "/users/\(user_id)"
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
                let json = JSON(result.value!)
                
                let user = User(json: json["user"])
                
                NSNotificationCenter.defaultCenter().postNotificationName("userFetched", object: user)
                
        }
    }
    
    func followUser(user_id: Int){
        
        followAPIController.followUser(user_id)
        
    }
    
    func unfollowUser(user_id: Int){
        
        followAPIController.unfollowUser(user_id)
        
    }
}
