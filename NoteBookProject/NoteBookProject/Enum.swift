//
//  Enum.swift
//  NoteBookProject
//
//  Created by zoho on 24/01/24.
//
enum CoreDataError: String{
    case CoreDataFetchingError = "Error: occured while fetch data from notes entity"
    case CoreDataSaveError = "Error: while saving the data in DataBase"
    case CoreDataDeleteError = "Error: while deleting the note in DataBase"
    case CoreDataNoChangesError = "Error: There is no Changes in the Context"
}
enum NibName: String{
    case TaskTableViewCell
    case CategoryTableViewCell
    case TextFieldTableViewCell
    case LoginFooterTableViewCell
    
}

enum ReuseIdentifier: String{
    case TaskTableCell
    case CategoryCell
    case TextFieldCell
    case LoginFooterCell
}

enum StoryBoardIdentifier: String{
    case EditNotesViewController
    case TaskCategory
}

enum AlertMessages: String{
    case SaveDataTitle = "Message"
    case SaveData = "Do you want to save your Notes?"
    case EditDataTitle = "Alert"
    case EditData = "Are you sure dou want to edit the Notes?"
}

enum PrototypeIdentifier: String{
    case Header
    case Footer
}


