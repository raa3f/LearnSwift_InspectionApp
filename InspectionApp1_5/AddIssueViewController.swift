//
//  AddIssueViewController.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import UIKit
import CoreData

class AddIssueViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var issueImage: UIImageView!
    @IBOutlet weak var severity: UIPickerView!
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        issueImage.image = image
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SelectImageFromLibrary(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func SelectImageFromCamera(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func SaveIssue(sender: AnyObject) {
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var destinationFolder = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var fileToWrite = destinationFolder.stringByAppendingPathComponent("issue\(NSDate()).jpg")
        UIImageJPEGRepresentation(issueImage.image, 0.5).writeToFile(fileToWrite, atomically: true)
 
        var issue = NSEntityDescription.insertNewObjectForEntityForName("Issues", inManagedObjectContext: managedContext) as NSManagedObject
        issue.setValue(selectedProjectName, forKey: "projectName")
        issue.setValue(desc.text, forKey: "issueDescription")
        issue.setValue("severity", forKey: "severity")
        issue.setValue(NSDate(), forKey: "createdDate")
        issue.setValue(fileToWrite, forKey: "imagePath")
        
        managedContext.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
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
