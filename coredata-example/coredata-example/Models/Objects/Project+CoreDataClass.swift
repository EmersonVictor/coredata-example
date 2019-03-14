//
//  Project+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//
//

import Foundation
import CoreData

public class Project: NSManagedObject {
    convenience public init(name: String, createdAt: Date, insertInto context: NSManagedObjectContext) {
        // Create description of project entity
        let description = NSEntityDescription.entity(forEntityName: "Project", in: context)
        
        // Use default initializer to create an instace of Project
        self.init(entity: description!, insertInto: context)
        
        // Set properties
        self.name = name
        self.createdAt = createdAt as NSDate
    }
}
