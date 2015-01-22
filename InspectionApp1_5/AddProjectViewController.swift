//
//  AddProjectViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var referenceNo: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var projectName: UITextField!
    
    @IBAction func SaveProject(sender: AnyObject) {
        
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var project = NSEntityDescription.insertNewObjectForEntityForName("Projects", inManagedObjectContext: managedContext) as NSManagedObject
        project.setValue(referenceNo.text, forKey: "referenceNo")
        project.setValue(companyName.text, forKey: "companyName")
        project.setValue(projectName.text, forKey: "projectName")
        project.setValue(NSDate(), forKey: "createdDate")
        project.setValue(kProjectDefaultImage, forKey: "imagePath")
        
        managedContext.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if textField == companyName {
            print("last text box returned")
        }
        
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
