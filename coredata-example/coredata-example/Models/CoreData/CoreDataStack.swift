//
//  CoreDataManager.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// MARK: - Core Data stack
class CoreDataStack {
    // MARK: - Application context
    static var context: NSManagedObjectContext {
        get {
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            return appDelegate.persistentContainer.viewContext
        }
    }
    
    // MARK: - Core Data Saving support
    static func saveContext() {
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}








