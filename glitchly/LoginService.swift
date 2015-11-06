//
//  LoginManager.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Locksmith

class LoginService: APIController {

    func login(username:String, password:String) {
        
        let parameters = [
            "auth": [
                "username": username,
                "password": password
            ]
        ]
        
        let url = apiURL + "/login"
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { request, response, result in
            
            let json = JSON(result.value!)
            let token:String = json["token"].string!
            
            do {
                
                try Locksmith.updateData(["token": token], forUserAccount: "myUserAccount")
                
                self.fetchCurrentUser()
                
            } catch {
                
                // todo handle error properly
                
            }
        }
        
    }
    
    func fetchCurrentUser() {
        
        let URL =  apiURL + "/refresh-navbar"
        
        let headers = ProtectedAPIController.setHeaders()
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { request, response, result in
                
                if result.value != nil {
                    
                    let json = JSON(result.value!)["user"]
                    
                    let user = User(json: json)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: user)
                    
                } else {
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: nil)
                    
                }
                
        }
        
    }
    
}
