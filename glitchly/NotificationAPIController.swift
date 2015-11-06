//
//  NotificationProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 11/4/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationAPIController: ProtectedAPIController {
    
    func getNotifications(page: Int){
        
        let url = apiURL + "/notifications?page=\(page)"
        
        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { request, response, result in
    
                let json = JSON(result.value!)
    
                var notifications:[Notification] = [Notification]()
                for notification in json["notifications"].array! {
                    notifications.append(Notification(json: notification))
                }
    
                NSNotificationCenter.defaultCenter().postNotificationName("notificationsFetched", object: notifications)
    
        }
    }

}
