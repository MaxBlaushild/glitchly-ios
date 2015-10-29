//
//  LikeManager.swift
//  glitchly
//
//  Created by Max Blaushild on 10/23/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Locksmith


class LikeManager: NSObject {
    

    
    func likePicture(picture_id: Int){
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let like = [
                "like": [
                ]
            ]
            
            let URL =  "http://159.203.86.38/pictures/\(picture_id)/likes"
            
            Alamofire.request(.POST, URL, parameters: like, headers: headers)
                .responseJSON { request, response, result in
                    
                    
            }
            
        } else {
            
            print("Error!!!!")
            
        }
        
    }
    
    func unlikePicture(picture_id: Int){
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38/pictures/\(picture_id)/likes"
            
            Alamofire.request(.DELETE, URL, headers: headers)
                .responseJSON { request, response, result in
                    
                    
            }
            
        } else {
            
            print("Error!!!!")
            
        }
        
    }

}
