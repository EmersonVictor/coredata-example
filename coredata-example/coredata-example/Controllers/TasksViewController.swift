//
//  TasksViewController.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 11/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class TasksViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    // MARK: - Variables
    var fetchedResultsController: NSFetchedResultsController<Task>!
    var project: Project? = nil
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view delegate and data source
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
        
        // Set interface with project information
        if let project = self.project {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            self.projectName.text = project.name
            self.createdAt.text = dateFormatter.string(from: project.createdAt as Date)
        }
        
        // Fetch all projects
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        // Sort fetch info
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "dueDate", ascending: true),
            NSSortDescriptor(key: "priority", ascending: true)
        ]
        
        // Predicate fetch info
        fetchRequest.predicate = NSPredicate(format: "project == %@", self.project!)
        
        // Create fetched results controller
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Perform fetch
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("There was an error fetching the list of project")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewTask" {
            let controller = segue.destination as! AddTaskViewController
            controller.project = (sender as! Project)
        }
    }
}

// MARK: - NSFetchedResultsController Delegate
extension TasksViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tasksTableView.reloadData()
    }
}


// MARK: - UITablewView Delegate
extension TasksViewController:  UITableViewDelegate {
    // Set row heigth
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    // Add new task action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addCellPosition = self.fetchedResultsController.sections![0].numberOfObjects + 1
        
        if indexPath.row == addCellPosition - 1 {
                self.performSegue(withIdentifier: "addNewTask", sender: self.project)
        }
    }
    
}

// MARK: - UITablewView Data Source
extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfTasks = self.fetchedResultsController.sections![indexPath.section].numberOfObjects
        
        if indexPath.row < numberOfTasks {
            let cell = tableView.dequeueReusableCell(withIdentifier: "task")!
            let task = self.fetchedResultsController.object(at: indexPath)
            
            cell.textLabel?.text = task.name
            cell.detailTextLabel?.text = "priority: \(task.priority)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewTask")!
            return cell
        }
    }
}

