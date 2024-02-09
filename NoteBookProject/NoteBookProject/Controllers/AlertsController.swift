//
//  AlertsController.swift
//  NoteBookProject
//
//  Created by zoho on 25/01/24.
//

import Foundation
import UIKit

class AlertsController{
    
    func alertBox(on viewController: UIViewController, title: String, messages: String, alertHandler: @escaping (_ action: UIAlertAction)->Void){
        
        print("alerts controller")
        let alert = UIAlertController(title: title, message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: alertHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController.present(alert, animated: true, completion: nil)
    }
}
