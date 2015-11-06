//
//  UserSearchCellDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 11/5/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class UserSearchCellDecorator: NSObject {
        
    func decorateFollowUnfollowButton(cell: UserSearchTableViewCell, user: User){
        let buttonLabel:String!
        
        if (user.followedByUser){
            buttonLabel = "Unfollow"
        } else {
            buttonLabel = "Follow"
        }
        cell.followOrUnfollowButton.setTitle(buttonLabel, forState: .Normal)
    }
    

}
