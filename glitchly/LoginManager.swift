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
import CoreData

class LoginManager: NSObject {
    
    let context:NSManagedObjectContext
    let entity:NSEntityDescription
    
    override init(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.context = appDelegate.managedObjectContext
        self.entity = NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
    }

    
    private func upsertUserDataToCore(username: String, email: String, profile_url: String, thumb_url:String, id:Int){
        
        let request = NSFetchRequest(entityName: "User")
        let predicate = NSPredicate(format: "id = %@", String(id))
        request.predicate = predicate
        request.fetchLimit = 1
        
        let result:[NSManagedObject]
        
        do {
            
            result = try context.executeFetchRequest(request) as! [NSManagedObject]
            
            if result.count > 0 {
                addCurrentUserToCore(username, email: email, profile_url: profile_url, thumb_url:thumb_url, id: id)
            }
            
        } catch {
            
            return
            
        }

    }
    
    private func addCurrentUserToCore(username: String, email: String, profile_url: String, thumb_url:String, id:Int) {
        
        let user:NSManagedObject = NSManagedObject(entity: entity, insertIntoManagedObjectContext:context) as NSManagedObject
        
        user.setValue(username, forKey: "username")
        user.setValue(profile_url, forKey: "profile_url")
        user.setValue(thumb_url, forKey: "thumb_url")
        user.setValue(email, forKey: "email")
        user.setValue(id, forKey: "id")
        
        do {
            
            try context.save()
            
        } catch {
            
            print("you done goofed!")
            
        }
        
    }
    
    func login(username:String, password:String) {
        
        let parameters = [
            "auth": [
                "username": username,
                "password": password
            ]
        ]
        
        Alamofire.request(.POST, "https://desolate-gorge-7593.herokuapp.com/login", parameters: parameters).responseJSON { request, response, result in
            
            let json = JSON(result.value!)
            let token:String = json["token"].string!
            
            
            do {
                
                try Locksmith.updateData(["token": token], forUserAccount: "myUserAccount")
                
            } catch {
                
            }
        }
        
    }
    
    func fetchCurrentUser() {
        
        if let user:Dictionary = Locksmith.loadDataForUserAccount("myUserAccount") {
            
            let token:String = user["token"] as! String
            
            let headers = [
                "Authorization": "Token token=\(token)",
            ]
                
            let URL =  "https://desolate-gorge-7593.herokuapp.com/refresh-navbar"
                
            Alamofire.request(.GET, URL, headers: headers)
                .responseJSON { request, response, result in
                
                    if result.value != nil {
                        
                        let json = JSON(result.value!)
                        let user = json["user"]
                        self.upsertUserDataToCore(user["username"].string!, email: user["email"].string!, profile_url: user["profile_url"].string!, thumb_url: user["thumb_url"].string!, id: user["id"].int!)
                        
                        
                        
                       NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: true)
                        
                    } else {
                        
                       NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: false)
                        
                    }

                    
            }
            
        } else {
            
            NSNotificationCenter.defaultCenter().postNotificationName("loggedIn", object: false)
            
        }
    }

    
}
