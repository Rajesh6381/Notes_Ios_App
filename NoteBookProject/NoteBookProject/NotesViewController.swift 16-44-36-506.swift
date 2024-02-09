//
//  ViewController.swift
//  NoteBookProject
//
//  Created by zoho on 22/01/24.
//

import UIKit

class NotesViewController:  UIViewController , UITableViewDataSource, UITableViewDelegate, EditingNotes{
    // Notes Data from core data
    let coreData = CoreDataManager.shared
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var navigationBarItem: UIBarButtonItem!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func editNote(title: String, description: String,index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        table.reloadRows(at: [indexPath], with: .automatic)
        print("Reloaded")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TaskTableViewCell.nib(), forCellReuseIdentifier: ReuseIdentifier.TaskTableCell.rawValue)

        
        table.delegate = self
        table.dataSource = self
        
        self.navigationBarItem.title = "Edit"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func navigationBarEdit(_ sender: UIBarButtonItem) {
        if(self.table.isEditing){
            sender.title = "Edit"
            self.table.isEditing = false
        }else{
            sender.title = "Done"
            self.table.isEditing = true
        }
    }
    
    @IBAction func upComingEvent(_ sender: UIButton) {
        if let push = storyboard?.instantiateViewController(identifier: StoryBoardIdentifier.TaskCategory.rawValue) as? CategoryTableViewController{
            push.sectionsByTask = dataSeparater()
            self.navigationController?.pushViewController(push, animated: true)
        }
    }
    
    func dataSeparater() -> [[(String,Bool,Int)]]{
        
        let todayDate =  Date()//today
        let tomorrow =  Calendar.current.date(byAdding: .day, value: 1, to: todayDate)! //tomorrow
        var index = 0
        var filterData: [[(String,Bool,Int)]] = [[],[],[]]
        guard let filterNotes = coreData.notes else{
            return filterData
        }
        for note  in filterNotes {
            if(note.notesDate! > tomorrow){
                filterData[2].append((note.notesTitle!,note.notesStatus,index))
            }else if note.notesDate! > todayDate{
                filterData[1].append((note.notesTitle!,note.notesStatus,index))
            }else{
                filterData[0].append((note.notesTitle!,note.notesStatus,index))
            }
            index += 1
        }
        return filterData
    }
    
    //data sources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let counts = coreData.notes?.count{
            return counts
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.TaskTableCell.rawValue, for: indexPath) as? TaskTableViewCell else{
            return TaskTableViewCell()
        }
        cell.update(note: coreData.notes![indexPath.row])
        return cell
    }
    
    
    
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let push = storyboard?.instantiateViewController(identifier: StoryBoardIdentifier.EditNotesViewController.rawValue) as? EditNotesViewController{
            push.note = coreData.notes?[indexPath.row]
            push.index = indexPath.row
            push.delegate = self
            self.navigationController?.pushViewController(push, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        coreData.notes?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        coreData.saveData()
    }
   
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            self.deleteRow(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let action = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
              self.deleteRow(index: indexPath)
          }
          
          return UISwipeActionsConfiguration(actions: [action])
    }
    
   
    
    func deleteRow(index: IndexPath){
        if let removeNotes = coreData.notes?[index.row]{
            coreData.notes?.remove(at: index.row)
            self.table.deleteRows(at: [index], with: .fade)
            CoreDataManager.shared.deleteData(note: removeNotes)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { // editing is not working
        if(coreData.context.hasChanges){
            print("changes")
            coreData.saveData()
            let indexPath = IndexPath(row: self.coreData.notes!.count - 1 , section: 0)
            table.insertRows(at: [indexPath], with: .bottom)
        }else if (coreData.notes == nil ){
            coreData.fetchData()
        }else{
            print("Nothing will happens")
        }
    }
}





