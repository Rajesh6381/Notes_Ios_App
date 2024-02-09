//
//  LoginTableViewController.swift
//  NoteBookProject
//
//  Created by zoho on 31/01/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TextFieldTableViewCell.nib(), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        
        table.register(UINib(nibName: NibName.LoginFooterTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: LoginFooterTableViewCell.identifier.rawValue)
        print("viewdid")
        changeOritentaion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyBoardShow(notification: Notification){
        if UIDevice.current.orientation.isPortrait {
            table.isScrollEnabled = true
        }
    }
    
    @objc func keyBoardHide(notification: Notification){
        if UIDevice.current.orientation.isPortrait{
            table.isScrollEnabled = false
        }
    }
    func changeOritentaion(){
        if UIDevice.current.orientation.isLandscape{
            table.isScrollEnabled = true
        }else{
            table.isScrollEnabled = false
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        changeOritentaion()
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: PrototypeIdentifier.Header.rawValue, for: indexPath)
            return cell
        }else if indexPath.row == 1 || indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as! TextFieldTableViewCell
            cell.labelName.text = indexPath.row == 1 ? "Email" : "Password"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginFooterTableViewCell.identifier.rawValue, for: indexPath) as! LoginFooterTableViewCell
            cell.instance = self
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200.0
        }else if indexPath.row == 1 || indexPath.row == 2{
            return 85.0
        }else{
            return 200.0
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
