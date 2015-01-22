//
//  Project.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import Foundation
import CoreData

@objc(Project)
class Project: NSManagedObject {
    
    @NSManaged var imagePath: String!
    @NSManaged var referenceNo: String!
    @NSManaged var projectName: String!
    @NSManaged var companyName: String!
    @NSManaged var createdDate: NSDate!
    @NSManaged var updatedDate: NSDate!
    
}