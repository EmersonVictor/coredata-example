//
//  ProjectsViewController+TableViewDelegate.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 14/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITablewView Delegate
extension ProjectsViewController:  UITableViewDelegate {
    
    // MARK: - Select project
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Select project in the fetched results controller
        let selectedProject = self.fetchedResultsController.object(at: indexPath)
        
        // Go to the tasks of a project
        self.performSegue(withIdentifier: "showProjectTasks", sender: selectedProject)
    }
    
    // MARK: - Table view swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = self.updateAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    // MARK: - Swipe contextual actions
    // Complete action
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            // Remove task from CoreData
            let selectedObject = self.fetchedResultsController.object(at: indexPath)
            
            CoreDataStack.context.delete(selectedObject)
            CoreDataStack.saveContext()
                        
            completion(true)
        }
        
        return action
    }
    
    // Update action
    func updateAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            // Get selected project
            let selectedCell = self.fetchedResultsController.object(at: indexPath)
            
            // Create update alert
            let updateAlert = UIAlertController(title: "Update project", message: "Enter a new name for your project", preferredStyle: .alert)
            
            
            // Add the text field
            updateAlert.addTextField { (textField) in
                textField.text = selectedCell.name
            }
            
            // Create actions
            let okAction = UIAlertAction(title: "Update", style: .default, handler: { _ in
                selectedCell.name = updateAlert.textFields![0].text!
                CoreDataStack.saveContext()
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            
            // Add actions and present the alert
            updateAlert.addAction(okAction)
            updateAlert.addAction(cancelAction)
            self.present(updateAlert, animated: true, completion: nil)
        }
        
        // Action interface
        action.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        return action
    }
}
