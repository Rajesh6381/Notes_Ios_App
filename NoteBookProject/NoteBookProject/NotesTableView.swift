//
//  NotesTableView.swift
//  NoteBookProject
//
//  Created by zoho on 31/01/24.
//

import Foundation
import UIKit

class NotesTableView: UITableView{
    
    var notes: [Notes]?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = notes?.count{
            return count
        }
        return 0
    }
    
    
    
    
    
    
    
}
