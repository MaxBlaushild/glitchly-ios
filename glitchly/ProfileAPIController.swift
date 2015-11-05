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


class ProfileAPIController: APIController {
    
    func getUserProfile(user_id: Int){

        let URL =  apiURL + "/users/\(user_id)"
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
                let json = JSON(result.value!)
                
                let user = User(json: json["user"])
                
                NSNotificationCenter.defaultCenter().postNotificationName("userFetched", object: user)
                
        }
    }
}
