//
//  NewFeedsTableViewController.swift
//  ParseFirstApp
//
//  Created by Bich Vu Ngoc on 12/23/27 H.
//  Copyright © 27 Heisei abearablecode. All rights reserved.
//

import UIKit
import Parse

class NewFeedsTableViewController: UITableViewController {
    
    var timelineData:NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        let findTimelineData = PFQuery(className: "Post")
        findTimelineData.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error: NSError?) -> Void in
            
            if error == nil{
                for object in objects!{
                    let post:PFObject = object as! PFObject 
                    self.timelineData.addObject(post)
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array: array)
                
                self.tableView.reloadData()
                
            }
            
        }
    }

    override func viewDidAppear(animated: Bool){
        self.loadData()
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }

    }
    
    @IBAction func LogoutAction(sender: AnyObject){
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timelineData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewFeedTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewFeedTableViewCell
        
        let post:PFObject = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
        cell.postTextView.alpha = 0
        cell.timestampLabel.alpha = 0
        cell.usernameLabel.alpha = 0
        
        cell.postTextView.text = post.objectForKey("content") as! String
        
        let dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestampLabel.text = dataFormatter.stringFromDate(post.createdAt!)
        
        cell.usernameLabel.text = (post.objectForKey("user")?.fetchIfNeeded() as! PFUser).username
        
        UIView.animateWithDuration(0.5, animations: {
            cell.postTextView.alpha = 1
            cell.timestampLabel.alpha = 1
            cell.usernameLabel.alpha = 1
        })
        
    return cell
    }

    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
