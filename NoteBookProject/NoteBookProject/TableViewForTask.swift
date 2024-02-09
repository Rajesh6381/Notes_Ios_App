//
//  TableViewForTask.swift
//  NoteBookProject
//
//  Created by zoho on 25/01/24.
//
import UIKit
import Foundation

class TableViewForTask: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    
    
    let coreData = CoreDataManager.shared
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var navigationBarItem: UIBarButtonItem!
    
     func main() {

        table.register(TaskTableViewCell.nib(), forCellReuseIdentifier: ReuseIdentifier.TaskTableCell.rawValue)
        
        table.delegate = self
        table.dataSource = self
        
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
    
    func dataSeparater() -> [[String]]{
        
        let todayDate =  Date()//today
        let tomorrow =  Calendar.current.date(byAdding: .day, value: 1, to: todayDate)! // tomorrow
        var filterData: [[String]] = [[],[],[]]
        print(coreData.notes)
        for note  in coreData.notes{
            if(note.notesDate! > tomorrow){
                filterData[2].append(note.notesTitle!)
            }else if note.notesDate! > todayDate{
                filterData[1].append(note.notesTitle!)
            }else{
                filterData[0].append(note.notesTitle!)
            }
        }
        
        return filterData
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let popedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), popedViewController == self{
        }
    }
    
   
    
    
    //data sources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.TaskTableCell.rawValue, for: indexPath) as! TaskTableViewCell
        
        cell.update(note: coreData.notes[indexPath.row])
        return cell
    }
    
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let push = storyboard?.instantiateViewController(identifier: StoryBoardIdentifier.TaskViewController.rawValue) as? TaskViewController{
            push.note = coreData.notes[indexPath.row]
            self.navigationController?.pushViewController(push, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        coreData.notes.swapAt(sourceIndexPath.row, destinationIndexPath.row)
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
        let removeNotes = coreData.notes[index.row]
        coreData.notes.remove(at: index.row)
        self.table.beginUpdates()
        self.table.deleteRows(at: [index], with: .fade)
        self.table.endUpdates()
        CoreDataManager.shared.deleteData(note: removeNotes)
    }
    
}
