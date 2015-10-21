//
//  ProfileViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user_id:Int = 0
    
    private let profileDecorator = ProfileDecorator()
    private let profileProvider = ProfileProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserRecieved:", name:"userFetched", object: nil)
        profileProvider.getUserProfile(user_id)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onUserRecieved(notification: NSNotification){
        
        if let user = notification.object as? User {
            profileDecorator.decorateProfilePicture(profilePicture, user: user)
            profileDecorator.decorateUsernameLabel(usernameLabel, user: user)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
