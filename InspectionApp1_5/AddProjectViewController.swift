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
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    @IBAction func SaveProject(sender: AnyObject) {
        
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var managedContext: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        
        //save image to document folder in phone
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let destinationPath = documentsPath.stringByAppendingPathComponent(projectName.text + ".jpg")
        UIImageJPEGRepresentation(projectImage.image, 1.0).writeToFile(destinationPath, atomically: true)
        
        var project = NSEntityDescription.insertNewObjectForEntityForName("Projects", inManagedObjectContext: managedContext) as NSManagedObject
        project.setValue(referenceNo.text, forKey: "referenceNo")
        project.setValue(companyName.text, forKey: "companyName")
        project.setValue(projectName.text, forKey: "projectName")
        project.setValue(NSDate(), forKey: "createdDate")
        project.setValue(destinationPath, forKey: "imagePath")
        
        managedContext.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func GetImageFromCamera(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.editing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func SelectImageFromCameraRoll(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.editing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        projectImage.image = image
        print("image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
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
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        return true
    }
    
    func KeyboardDidShow(notification: NSNotificationCenter ) {
        self.view.frame = CGRectMake(0,-110,320,460)
        println("keyboard is up")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        return true;
    }
    func KeyboardDidHide(notification: NSNotificationCenter){
        self.view.frame = CGRectMake(0,0,320,460)
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
