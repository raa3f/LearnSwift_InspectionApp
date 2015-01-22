//
//  AddIssueViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class AddIssueViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var severity: UITextField!
    @IBOutlet weak var issueDescription: UITextField!
    @IBOutlet weak var issueImage: UIImageView!
    
    @IBAction func SaveIssue(sender: AnyObject) {
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var issue = NSEntityDescription.insertNewObjectForEntityForName("Issues", inManagedObjectContext: managedContext) as NSManagedObject
        issue.setValue(selectedProjectName, forKey: "projectName")
        issue.setValue(issueDescription.text, forKey: "issueDescription")
        issue.setValue(severity.text, forKey: "severity")
        issue.setValue(NSDate(), forKey: "createdDate")
        issue.setValue(kIssueDefaultImage, forKey: "imagePath")
        
        managedContext.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        desc.text = selectedProjectName
        print(selectedProjectName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
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
