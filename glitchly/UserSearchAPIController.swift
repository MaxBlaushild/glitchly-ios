//
//  UserSearchProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 11/2/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Locksmith
import SwiftyJSON
import Alamofire

class UserSearchAPIController: ProtectedAPIController {
    
    func searchForUsers(username: String) {
            
        let URL =  apiURL + "/users?username=\(username)"
            
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
            let json = JSON(result.value!)
            let jsonUsers:[JSON] = json["users"].array! as [JSON]
                
            var users = [User]()
            for user in jsonUsers {
                
                users.append(User(json: user))
                
            }
                
            NSNotificationCenter.defaultCenter().postNotificationName("usersFetched", object: users)
        }
        
    }

}
