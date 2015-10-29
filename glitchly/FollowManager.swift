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

class FollowManager: NSObject {

    func followUser(user_id: Int){
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38/users/\(user_id)/follow"
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    
                    
            }
            
        } else {
            
            print("Error!!!!")
            
        }
        
    }
    
    func unfollowUser(user_id: Int){
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38/users/\(user_id)/unfollow"
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    
                    
            }
            
        } else {
            
            print("Error!!!!")
            
        }
        
    }

}
