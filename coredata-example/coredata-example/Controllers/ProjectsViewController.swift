//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Emerson Victor on 08/03/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var projectsTableView: UITableView!
    
    // MARK: - Variables
    var fetchedResultsController: NSFetchedResultsController<Project>!

    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view delegate and data source
        self.projectsTableView.dataSource = self
        self.projectsTableView.delegate = self
        
        // Fetch all projects
        let fetchRequest = NSFetchRequest<Project>(entityName: "Project")
        
        // Sort fetch info
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        // Create fetched results controller
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Perform fetch
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("There was an error fetching the list of project")
        }
    }
    
    // MARK: - Prepare for show tasks of a project
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send Task object to TasksViewController
        if segue.identifier == "showProjectTasks" {
            let controller = segue.destination as! TasksViewController
            controller.project = sender as? Project
        }
    }
}

// MARK: - NSFetchedResultsController Delegate
extension ProjectsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.projectsTableView.reloadData()
    }
}

// MARK: - UITablewView Data Source
extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project")!
        let project = self.fetchedResultsController.object(at: indexPath)
        
        // Create and set date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Set cell information
        cell.textLabel?.text = project.name
        cell.detailTextLabel?.text = dateFormatter.string(from: project.createdAt as Date)
        
        return cell
    }
}
