//
//  Issue.swift
//  InspectionApp1_5
//
//  Created by Raaef Khan on 23/01/2015.
//  Copyright (c) 2015 Raaef Khan. All rights reserved.
//

import Foundation
import CoreData

@objc(Issue)
class Issue: NSManagedObject {

    @NSManaged var projectName: String!
    @NSManaged var imagePath: String!
    @NSManaged var issueDescription: String!
    @NSManaged var severity: String!
    @NSManaged var creaatedDate: NSDate!

}
