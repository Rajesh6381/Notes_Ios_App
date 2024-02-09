//
//  TextFieldTableViewCell.swift
//  NoteBookProject
//
//  Created by zoho on 23/01/24.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    static let identifier = ReuseIdentifier.TextFieldCell.rawValue
    @IBOutlet var labelName: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: NibName.TextFieldTableViewCell.rawValue, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
