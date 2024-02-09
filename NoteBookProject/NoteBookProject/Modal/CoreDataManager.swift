//
//  CoreDataManager.swift
//  NoteBookProject
//
//  Created by zoho on 24/01/24.
//

import UIKit
import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    // create a context for managing object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let contextmodel = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    let request: NSFetchRequest<Notes>
    var notes: [Notes]?
    
    init(){
        request = Notes.fetchRequest()
        let sort = NSSortDescriptor(key: "notesDate", ascending: true)
        request.sortDescriptors = [sort]
        
        print()
    }
    
    func fetchData(){
        do{
            try self.notes =  context.fetch(request)
            
        }catch{
            print(CoreDataError.CoreDataFetchingError.rawValue)
        }
    }
    

    
    func deleteData(note: Notes){
        context.delete(note)
        saveData()
    }
    
    func updateStatusNotesByIndex(index: Int){
        if let note = notes?[index]{
            note.notesStatus = true
            saveData()
            print("updated status")
        }
    }
    
    func saveData(){
        if(!context.hasChanges){
            print(CoreDataError.CoreDataNoChangesError.rawValue)
            return
        }
        do{
            try context.save()
            print("saved")
        }catch{
            print(CoreDataError.CoreDataSaveError.rawValue)
        }
        fetchData()
        
    }
    
    
}
