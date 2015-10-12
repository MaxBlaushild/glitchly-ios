//
//  User+CoreDataProperties.swift
//  
//
//  Created by Max Blaushild on 10/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var email: String?
    @NSManaged var profile_url: String?
    @NSManaged var thumb_url: String?
    @NSManaged var username: String?
    @NSManaged var id: NSNumber?

}
