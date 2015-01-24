//
//  ViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        
        cell.imageView?.image = UIImage(named: projects[indexPath.row].imagePath)
        cell.textLabel?.text = projects[indexPath.row].projectName
        cell.detailTextLabel?.text = projects[indexPath.row].referenceNo
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedProjectName = projects[indexPath.row].projectName
        self.performSegueWithIdentifier("IssuesSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if DeleteProject(projects[indexPath.row]) {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                ReloadData()
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        projects.filter({(project: Project)-> Bool in
            
            return true
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ReloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        ReloadData()
        table.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func ReloadData(){
        projects = []
        selectedProjectName = nil
        
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var resource = NSFetchRequest(entityName: "Projects")
        
        var result = managedContext.executeFetchRequest(resource, error: nil)
        
        for i in result as [Project] {
            projects.append(i)
        }
    }
    
    func DeleteProject(project: Project) -> Bool {
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var resource = NSFetchRequest(entityName: "Projects")
        
        var result = managedContext.executeFetchRequest(resource, error: nil)
        
        var count = 0
        for i in result as [Project] {
            if project == i {
                projects.removeAtIndex(count)
                managedContext.deleteObject(i as NSManagedObject)
                managedContext.save(nil)
                return true
            }
            count++
        }
        
        return false
    }

}

