//
//  ProfileViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var followOrUnfollowButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureCollection: UICollectionView!
    
    var user_id:Int = 0
    var currentUser:User = User()
    
    private let profileDecorator = ProfileDecorator()
    private let profileProvider = ProfileProvider()
    private var user:User = User()
    private let followManager = FollowManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserRecieved:", name:"userFetched", object: nil)
        profileProvider.getUserProfile(user_id)

        // Do any additional setup after loading the view.
        
        profilePictureCollection.dataSource = self
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profilePictureCell", forIndexPath: indexPath) as! ProfilePictureCell
        
        cell.imageView.image = profileDecorator.fetchCollectionCellPicture(user.pictures[indexPath.row])
        
        return cell
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.pictures.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onUserRecieved(notification: NSNotification){
        
        if let fetchedUser = notification.object as? User {
            user = fetchedUser
            renderFetchedUser()
        }
        
    }
    
    func renderFetchedUser(){
        
        profilePicture.image = profileDecorator.fetchProfilePicture(user)
        usernameLabel.text = user.username
        renderFollowUnfollowButton()
        profilePictureCollection.reloadData()
        
    }
    
    func renderFollowUnfollowButton(){
        if currentUser.id == user.id {
            followOrUnfollowButton.removeFromSuperview()
        } else {
            if user.followedByUser {
                followOrUnfollowButton.setTitle("Unfollow", forState: .Normal)
            } else {
                followOrUnfollowButton.setTitle("Follow", forState: .Normal)
            }
        }

    }
    
    @IBAction func followOrUnfollow(sender: AnyObject) {
        user.followedByUser ? followManager.unfollowUser(user.id) : followManager.followUser(user.id)
        user.followedByUser = !user.followedByUser
        renderFollowUnfollowButton()
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
