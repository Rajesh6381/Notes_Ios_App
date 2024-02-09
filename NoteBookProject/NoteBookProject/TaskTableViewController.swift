//
//  TaskTableViewController.swift
//  NoteBookProject
//
//  Created by zoho on 22/01/24.
//


import UIKit

class TaskTableViewController: UITableViewController{
    let task: [Task] = [data1,data2,data3,data4,data5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TaskCell
        let message = task[indexPath.row]

        
        cell.update(task: message)
        
        
        return cell
    }
}

