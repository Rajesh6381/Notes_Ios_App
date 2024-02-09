//
//  TaskViewController.swift
//  NoteBookProject
//
//  Created by zoho on 24/01/24.
//

protocol EditingNotes{
    func editNote(title: String, description: String,index: Int)
}

import UIKit

class EditNotesViewController: UIViewController {
    
    var delegate: EditingNotes?
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var notesDateLabel: UILabel!
    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesDecription: UITextView!
    
    @IBOutlet weak var notesDate: UIDatePicker!
    @IBOutlet weak var notesDescriptionLabel: UILabel!
    @IBOutlet weak var notesTitleLabel: UILabel!
    var note: Notes?
    var index: Int?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape{
            self.scroll.isScrollEnabled = true
        }else{
            self.scroll.setContentOffset(CGPoint.zero, animated: true)
            self.scroll.isScrollEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notesTitle.text = note?.notesTitle ?? ""
        self.notesDecription.text = note?.notesDescription ?? ""
        
        self.notesDate.minimumDate = note?.notesDate
        self.notesDate.maximumDate = note?.notesDate
        
        self.navigationItem.title = "View Notes"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editingAction))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if UIDevice.current.orientation.isLandscape{
            self.scroll.isScrollEnabled = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyBoardWillShow(notification: Notification){
        if(!self.scroll.isScrollEnabled){
            self.scroll.isScrollEnabled = true
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification){
        if(UIDevice.current.orientation.isPortrait){
            self.scroll.setContentOffset(CGPoint.zero, animated: true)
            self.scroll.isScrollEnabled = false
        }
    }
    
    @objc func editingAction(){        
        notesTitle.isEnabled =  true
        notesDecription.isEditable = true
        self.notesDate.maximumDate = nil
        
        notesTitle.layer.borderWidth = 0.3
        notesDecription.layer.borderWidth = 0.3
        notesTitleLabel.text = "Notes Title *"
        notesDescriptionLabel.text = "Notes Description *"
        notesDateLabel.text = "Notes Date *"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
        
    }
    
    @objc func saveAction(){
        guard let row = index else{
            return
        }
        let alert = AlertsController()
        alert.alertBox(on: self, title: AlertMessages.EditDataTitle.rawValue, messages: AlertMessages.EditData.rawValue, alertHandler: {
            action in
            self.note?.notesTitle = self.notesTitle.text
            self.note?.notesDescription = self.notesDecription.text
            self.note?.notesDate = self.notesDate.date
            
            CoreDataManager.shared.saveData()
            self.delegate?.editNote(title: self.notesTitle.text ?? "", description: self.notesDecription.text ?? "",index: row)
            print("Data Passed")
            self.navigationController?.popViewController(animated: true)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
