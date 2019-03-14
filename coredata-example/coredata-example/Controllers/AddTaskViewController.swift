//
//  AddTaskViewController.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityPicker: UIStepper!
    @IBOutlet weak var dueDate: UIDatePicker!
    
    // MARK: - Variables
    var project: Project?
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set text field delegate
        self.name.delegate = self
    }
    
    // MARK: - Save task
    @IBAction func saveTask() {
        // Create managed object
        _ = Task(name: self.name.text!, priority: self.priorityPicker.value, dueDate: self.dueDate.date, toProject: self.project!, createdAt: Date(), insertInto: CoreDataStack.context)
        
        
        // Save context
        CoreDataStack.saveContext()
        
        // Back to main view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Change priority label
    @IBAction func changePriority(_ sender: UIStepper) {
        self.priorityLabel.text = "\(Int(sender.value))"
    }
}

// MARK: - Hide keyboard on return
extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
