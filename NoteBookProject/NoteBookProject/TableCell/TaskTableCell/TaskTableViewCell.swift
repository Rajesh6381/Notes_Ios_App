//
//  TaskTableViewCell.swift
//  NoteBookProject
//
//  Created by zoho on 23/01/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var notesTitle: UILabel!
    @IBOutlet weak var inboxImage: UIImageView!
    @IBOutlet weak var favourite: UIButton!
    
    
    static func nib() -> UINib{
        return UINib(nibName: NibName.TaskTableViewCell.rawValue, bundle:nil)
    }
    
    
    func update(note: Notes){
        self.notesTitle.text = note.notesTitle
        inboxImage.layer.cornerRadius = 18
    }
    
    @IBAction func favouriteButton(_ sender: UIButton){
        if(sender.isSelected){
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }else{
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
    
    
    
    
}

