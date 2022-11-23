//
//  TaskTypeVC.swift
//  To-Do Manager
//
//  Created by Айдар Абдуллин on 22.11.2022.
//

import UIKit

class TaskTypeVC: UITableViewController {
    
    typealias TypeCellDescription = (type: TaskPriority,
                                     title: String,
                                     description: String)

    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .important, title: "Important", description: "This type of task is the highest priority to perform. All important tasks are displayed at the very top of the task list"),
        (type: .normal, title: "Current", description: "A task with a normal priority")]
    
    var selectedType: TaskPriority = .normal
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellTypeNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TaskTypeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypesInformation.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        let typeDescription = taskTypesInformation[indexPath.row]
        
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = taskTypesInformation[indexPath.row].type
        doAfterTypeSelected?(selectedType)
        navigationController?.popViewController(animated: true)
    }
}
