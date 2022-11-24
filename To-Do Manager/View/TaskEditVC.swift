//
//  TaskEditVC.swift
//  To-Do Manager
//
//  Created by Айдар Абдуллин on 22.11.2022.
//

import UIKit

class TaskEditVC: UITableViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskTypeLabel: UILabel!
    @IBOutlet weak var taskStatusSwitch: UISwitch!
    
    
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    private var taskTitles: [TaskPriority:String] = [
        .important: "Important",
        .normal: "Current"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitle?.text = taskText
        taskTypeLabel?.text = taskTitles[taskType]
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard taskTitle.text != "" else {
            alert(title: "Warning", message: "Fill the task title", style: .alert)
            return
        }
        
        let title = taskTitle.text!
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        doAfterEdit?(title, type, status)
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TaskTypeVC
        destination.selectedType = taskType
        destination.doAfterTypeSelected = { [unowned self] selectedType in
            taskType = selectedType
            taskTypeLabel?.text = taskTitles[taskType]
        }
    }
    
        //MARK: Methods
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(actionOK)
        
        self.present(alert, animated: true, completion: nil)
    }
}
