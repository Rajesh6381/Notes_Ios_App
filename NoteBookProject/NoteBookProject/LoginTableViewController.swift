//
//  LoginTableViewViewController.swift
//  NoteBookProject
//
//  Created by zoho on 23/01/24.
//

import UIKit
import Charts

class LoginTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let sections = ["Email","Password"]

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var table:UITableView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TextFieldTableViewCell.nib(), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow),name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide),name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if UIDevice.current.orientation.isLandscape {
            self.scrollView.isScrollEnabled = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape{
            self.scrollView.isScrollEnabled = true
        }else{
            self.scrollView.isScrollEnabled = false
        }
    }

    @objc func handleKeyboardShow(notification: Notification) {
        if(UIDevice.current.orientation.isPortrait){
            self.scrollView.isScrollEnabled = true
        }
    }
    
    @objc func handleKeyboardHide(notification: Notification) {
        if(UIDevice.current.orientation.isPortrait){
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            self.scrollView.isScrollEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as! TextFieldTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
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
