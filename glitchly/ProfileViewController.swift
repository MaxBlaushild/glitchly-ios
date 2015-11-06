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
    
    // api controllers
    private let profileAPIController = ProfileAPIController()
    private let followAPIController = FollowAPIController()
    
    // passed over from feedcontroller
    var feedAPIController:FeedAPIController!
    var user_id:Int!
    var currentUser:User!
    
    private let profileDecorator = ProfileDecorator()
    private var user:User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onUserRecieved:", name:"userFetched", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFollowStatusToggledInAPI:", name:"followStatusToggled", object: nil)
        
        profileAPIController.getUserProfile(user_id)

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
        profilePicture.frame = CGRect(x: 25, y: 25, width: 50, height: 50)
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
        
        user.followedByUser ? followAPIController.unfollowUser(user.id) : followAPIController.followUser(user.id)
        
    }
    
    func onFollowStatusToggledInAPI(notification:NSNotification){
        
        user.followedByUser = !user.followedByUser
        renderFollowUnfollowButton()
        resetFeed()
        
    }
    
    func resetFeed(){
        
        feedAPIController.getFeed()
        
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
