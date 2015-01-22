//
//  ViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
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

}

