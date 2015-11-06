//
//  NotificationsTableViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 11/4/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.//

import UIKit

class NotificationsTableViewController: UITableViewController {
    
    private var notificationsPage:Int = 0
    private let notificationsAPIController:NotificationAPIController = NotificationAPIController()
    private let notificationsTableViewCellDecorator:NotificationsTableViewCellDecorator = NotificationsTableViewCellDecorator()
    private var notifications:[Notification] = [Notification]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onNotificationsReceived:", name:"notificationsFetched", object: nil)
        notificationsAPIController.getNotifications(notificationsPage)
    }
    
    func onNotificationsReceived(notification: NSNotification) {
        notifications = notification.object as! [Notification]
        tableView.reloadData()
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
        return notifications.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationsTableViewCell", forIndexPath: indexPath) as! NotificationsTableViewCell

        let notification:Notification = notifications[indexPath.row]
        renderNotificationCell(cell, notification: notification)
        
        return cell
    }

    func renderNotificationCell(cell: NotificationsTableViewCell, notification:Notification) {
        
        cell.textLabel!.text = notification.body
        cell.tag = notification.segueId
        cell.notificationImageView.image = notificationsTableViewCellDecorator.fetchNotificationPicture(notification.displayPictureURL)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
