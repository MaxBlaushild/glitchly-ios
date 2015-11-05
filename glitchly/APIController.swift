//
//  Provider.swift
//  glitchly
//
//  Created by Max Blaushild on 11/4/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Locksmith

class APIController: NSObject {
    
    let apiURL:String
    let headers:Dictionary<String, String>
    
    override init(){
        
        apiURL = "http://159.203.86.38"
        
        headers = APIController.setHeaders(Locksmith.loadDataForUserAccount("myUserAccount")!)

    }
    
    static func setHeaders(tokenWrapper: Dictionary<String, AnyObject>) -> Dictionary<String, String> {
        
        let token = tokenWrapper["token"] as! String
        
        let headers = [
            "Authorization": "Token token=\(token)"
        ]
        
        return headers
    }

}
