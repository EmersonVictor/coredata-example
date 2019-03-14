//
//  Task+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 14/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: NSDate
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var name: String
    @NSManaged public var priority: Int16
    @NSManaged public var project: Project

}
