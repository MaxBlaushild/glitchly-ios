//
//  FeedProvider.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Locksmith

class FeedProvider: NSObject {
    
    func getFeed() {
        let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount")!
        if let token:String = user["token"] as? String {
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
            
            let URL =  "http://159.203.86.38"
            
            //        let URL = "https://httpbin.org/get"
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    let json = JSON(result.value!)
                    let jsonPictures:[JSON] = json["pictures"].array! as [JSON]
                    
                    var pictures = [Picture]()
                    for picture in jsonPictures {
                        let newPic = Picture()
                        newPic.url = picture["large_url"].string!
                        newPic.caption = picture["caption"].string!
                        newPic.creatorId = picture["user"]["id"].int!
                        newPic.likes = picture["likes"].int!
                        newPic.creatorName = picture["user"]["username"].string!
                        newPic.creatorThumb = picture["user"]["thumb_url"].string!
                        for comment in picture["comments"].array! {
                            let newComment = Comment()
                            newComment.body = comment["body"].string!
                            newComment.id = comment["id"].int!
                            newComment.username = comment["user"]["username"].string!
                            newComment.user_id = comment["user"]["id"].int!
                            newComment.user_thumb = comment["user"]["profile_url"].string!
                            newPic.comments.append(newComment)
                        }
                        pictures.append(newPic)
                    }
                    
                NSNotificationCenter.defaultCenter().postNotificationName("feedFetched", object: pictures)
                    
                }
            
            }

        }
        
}
