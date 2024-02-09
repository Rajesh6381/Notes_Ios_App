//
//  NotesViewController.swift
//  NoteBookProject
//
//  Created by zoho on 31/01/24.
//
import UIKit
import Foundation

class NotesViewController: UITableViewController{
    
    @IBOutlet weak var table:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TaskTableViewCell.nib(), forCellReuseIdentifier: ReuseIdentifier.TaskTableCell.rawValue)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let counts = CoreDataManager.shared.notes?.count {
            return counts
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = 
        return
    }
    
    
}
