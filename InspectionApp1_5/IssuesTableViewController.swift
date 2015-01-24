//
//  IssuesTableViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class IssuesTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ReloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        ReloadData()
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return issues.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IssueCustomCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = issues[indexPath.row].issueDescription
        cell.imageView?.image = UIImage(named: issues[indexPath.row].imagePath)
        cell.detailTextLabel?.text = issues[indexPath.row].severity

        return cell
    }

    func ReloadData() {
        issues = []
        
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Issues")
        var result = managedContext.executeFetchRequest(request, error: nil)
        
        for i in result as [Issue] {
            if i.projectName == selectedProjectName {
                issues.append(i)
            }
            
        }
        
        
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if DeleteIssue(issues[indexPath.row]) {
                issues.removeAtIndex(indexPath.row)
                // Delete the row from the data source
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    func DeleteIssue(issue: Issue) -> Bool {
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Issues")
        var result = managedContext.executeFetchRequest(request, error: nil)
        
        for i in result as [Issue] {
            if i == issue {
                managedContext.deleteObject(i as NSManagedObject)
                managedContext.save(nil)

                return true
            }
        }
        
        return false
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
