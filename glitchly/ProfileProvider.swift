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


class ProfileProvider: NSObject {
    
    private let userSerializer = UserSerializer()
    
    func getUserProfile(user_id: Int){
        let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount")!
        if let token:String = user["token"] as? String {
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38/users/\(user_id)"
            
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    let json = JSON(result.value!)
                    let user = self.userSerializer.serializerUser(json)
                    NSNotificationCenter.defaultCenter().postNotificationName("userFetched", object: user)
                    
            }
        }
    }
    

}
