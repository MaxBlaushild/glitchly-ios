//
//  ProtectedAPIController.swift
//  glitchly
//
//  Created by Max Blaushild on 11/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Locksmith

class ProtectedAPIController: APIController {
    
    var headers:Dictionary<String, String>?
    
    override init(){
        
        headers = ProtectedAPIController.setHeaders()
        
    }
    
    static func setHeaders() -> Dictionary<String, String> {
        
        let tokenWrapper = Locksmith.loadDataForUserAccount("myUserAccount")!
        
        let token = tokenWrapper["token"] as! String
        
        let headers = [
            "Authorization": "Token token=\(token)"
        ]
        
        return headers
    }
    
    
}

