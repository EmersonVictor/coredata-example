//
//  Task+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//
//

import Foundation
import CoreData

public class Task: NSManagedObject {
    convenience public init(name: String, priority: Double, dueDate: Date? = nil, toProject project: Project, createdAt: Date, insertInto context: NSManagedObjectContext) {
        // Create description of task entity
        let description = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        // Use default initializer to create an instace of Project
        self.init(entity: description!, insertInto: context)
        
        // Set properties
        self.name = name
        self.priority = Int16(priority)
        self.dueDate = nil
        if let date = dueDate {
            self.dueDate = date as NSDate
        }
        self.createdAt = Date() as NSDate
        self.project = project
    }
}
