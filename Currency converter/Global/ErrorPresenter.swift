//
//  ErrorPresenter.swift
//  Currency converter
//
//  Created by Alex Mosunov on 22.10.2021.
//

import UIKit

class ErrorPresenter {

  static func showError(message: String, on viewController: UIViewController?, dismissAction: ((UIAlertAction) -> Void)? = nil) {
    weak var vc = viewController
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: "Error",
                                              message: message,
                                              preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: dismissAction))
      vc?.present(alertController, animated: true)
    }
  }
    
    static func showUserDataInput(viewController: UIViewController?, completed: @escaping (String) -> ()) {
        weak var vc = viewController
        DispatchQueue.main.async {
            var textFieldInput: String?
            let alertController = UIAlertController(title: "Please enter your token",
                                                    message: "You can get your token at api.monobank.ua",
                                                    preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Your token"
            }
            
            let doneAction = UIAlertAction(title: "done",
                                           style: .default) { action in
                textFieldInput = alertController.textFields![0].text
                completed(textFieldInput ?? "")
            }
            let cancelAction = UIAlertAction(title: "cancel", style: .default)
            
            alertController.addAction(doneAction)
            alertController.addAction(cancelAction)
            
            vc?.present(alertController, animated: true)
        }
        
        
//        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertController.Style.alert)
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter Second Name"
//        }
//        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
//            let firstTextField = alertController.textFields![0] as UITextField
//            let secondTextField = alertController.textFields![1] as UITextField
//        })
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
//            (action : UIAlertAction!) -> Void in })
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter First Name"
//        }
//
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//
//
//        vc?.present(alertController, animated: true)
//        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
