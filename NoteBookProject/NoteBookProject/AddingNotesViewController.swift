//
//  AddingNotesViewController.swift
//  NoteBookProject
//
//  Created by zoho on 23/01/24.
//

import UIKit

class AddingNotesViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var newNotesDate: UIDatePicker!
    @IBOutlet weak var newNotesTitle: UITextField!
    @IBOutlet weak var newNotesDecription: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newNotesDate.minimumDate = Date()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        if(UIDevice.current.orientation.isLandscape){
            self.scroll.isScrollEnabled = true
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func keyBoardHide(notification: Notification){
        if UIDevice.current.orientation.isPortrait{
            self.scroll.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    @objc func keyBoardShow(notification: Notification){
        if UIDevice.current.orientation.isPortrait {
            self.scroll.isScrollEnabled = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape{
            self.scroll.isScrollEnabled = true
        }else{
            self.scroll.isScrollEnabled = false
        }
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem){
        
        
        let alerts = AlertsController()
        alerts.alertBox(on: self, title: AlertMessages.SaveDataTitle.rawValue, messages: AlertMessages.SaveData.rawValue, alertHandler: {
            action in
            print("handler")
            let note = Notes(context: self.context)
            note.notesTitle = self.newNotesTitle.text == "" ? "UnKnown" : self.newNotesTitle.text
            note.notesDescription = self.newNotesDecription.text
            note.notesDate = self.newNotesDate.date
            note.notesStatus = false
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
