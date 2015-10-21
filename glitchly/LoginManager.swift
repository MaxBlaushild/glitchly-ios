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

class LoginManager: NSObject {
    
    private let userSerializer = UserSerializer()

    func login(username:String, password:String) {
        
        let parameters = [
            "auth": [
                "username": username,
                "password": password
            ]
        ]
        
        Alamofire.request(.POST, "http://159.203.86.38/login", parameters: parameters).responseJSON { request, response, result in
            
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
        
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
                
            let URL =  "http://159.203.86.38/refresh-navbar"
                
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                
                    if result.value != nil {
                        
                        let json = JSON(result.value!)
                        let user = self.userSerializer.serializerUser(json)
                        

                        NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: user)
                        
                    } else {
                        
                       NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: nil)
                        
                    }
                    
            }
            
        } else {
            
            NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: nil)
            
        }
    }

    
}
