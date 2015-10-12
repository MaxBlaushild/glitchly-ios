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
            
            let URL =  "https://desolate-gorge-7593.herokuapp.com"
            
            //        let URL = "https://httpbin.org/get"
            
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                    let json = JSON(result.value!)
                    let jsonPictures:JSON = json["pictures"] as JSON
                    var pictures = [Picture]()
                    for picture in jsonPictures {
                        let newPic = Picture()
                        newPic.url = picture.1["large_url"].string!
                        newPic.caption = picture.1["caption"].string!
                        newPic.creatorId = picture.1["user"]["id"].int!
                        newPic.likes = picture.1["likes"].int!
                        newPic.creatorName = picture.1["user"]["username"].string!
                        newPic.creatorThumb = picture.1["user"]["thumb_url"].string!
                        for comment in picture.1["comments"].array! {
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
