//
//  AddProjectViewController.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var name: UITextField!
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Save project
    @IBAction func saveProject() {
        
        // Create project
        _ = Project(name: self.name.text!, createdAt: Date(), insertInto: CoreDataStack.context)
        
        // Save context
        CoreDataStack.saveContext()
        
        // Back to main view controller
        self.navigationController?.popViewController(animated: true)
    }
}
