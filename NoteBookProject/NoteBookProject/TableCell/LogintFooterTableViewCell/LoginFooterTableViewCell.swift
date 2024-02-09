//
//  LoginFooterTableViewCell.swift
//  NoteBookProject
//
//  Created by zoho on 31/01/24.
//

import UIKit



class LoginFooterTableViewCell: UITableViewCell {
    
    static let identifier = ReuseIdentifier.LoginFooterCell
    var instance: TableViewController?
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    @IBAction func signIn(_ sender: UIButton){
        if let push = instance?.storyboard?.instantiateViewController(identifier: "NotesViewController") as? NotesViewController{
           
            instance?.navigationController?.pushViewController(push, animated: true)
        }
    }
    
}
