//
//  CategoryTableViewCell.swift
//  NoteBookProject
//
//  Created by zoho on 23/01/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cancelCompletedNotes: UIImageView!
    @IBOutlet weak var notesStatus: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    static let identifier = ReuseIdentifier.CategoryCell.rawValue
    
    
    static func nib() -> UINib{
        return UINib(nibName: NibName.CategoryTableViewCell.rawValue, bundle: nil)
    }
    
    func update(title: String,status: Bool){
        if(status){
            cancelCompletedNotes.isHidden = false
            notesStatus.image = .checkmark
            let attributedText = NSAttributedString(
                string: title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            labelTitle.attributedText = attributedText
            labelTitle.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            notesStatus.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        }else{
            cancelCompletedNotes.isHidden = true
            labelTitle.text = title
        }
    }
    

   
    
}
