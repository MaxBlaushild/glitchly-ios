//
//  FoundUsersTableViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 11/2/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FoundUsersTableViewController: UITableViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: nil)
    let userSearchAPIController = UserSearchAPIController()
    private var users:[User] = []
    
    var currentUser:User!
    var feedProvider:FeedAPIController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: "onUsersFetched:", name:"usersFetched", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let usernameQuery:String = searchController.searchBar.text!
        
        userSearchAPIController.searchForUsers(usernameQuery)
        
    }
    
    func onUsersFetched(notification: NSNotification){
        if let fetchedUsers:[User] = notification.object as? [User] {
            users = fetchedUsers
            tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSearchTableViewCell", forIndexPath: indexPath) as! UserSearchTableViewCell

        // Configure the cell...
        let user:User = users[indexPath.row]
        
        cell.textLabel!.text = user.username
        cell.tag = user.id
        
        let buttonLabel:String!
        
        if (user.followedByUser){
           buttonLabel = "Unfollow"
        } else {
            buttonLabel = "Follow"
        }
        cell.followOrUnfollowButton.setTitle(buttonLabel, forState: .Normal)
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchController.active = false
        if segue.identifier! == "searchToProfileSegue"
        {
            if let destinationVC = segue.destinationViewController as? ProfileViewController{
                destinationVC.user_id = sender!.tag
                destinationVC.currentUser = currentUser
                destinationVC.feedProvider = feedProvider
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        searchController.active = false
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
