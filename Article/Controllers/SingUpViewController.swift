//
//  SingUpViewController.swift
//  Article
//
//  Created by 陳冠甫 on 2021/4/2.
//

import UIKit
import Firebase

class SingUpViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    @IBAction func didCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "backToLoginView", sender: nil)
    }
    
    @IBAction func didSveInfo(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error",
                                      message: "Check Your Info",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        guard firstNameField.text != "",
              lastNameField.text != "",
              emailField.text != "",
              passwordField.text != "" else {
            present(alert, animated: true, completion: nil)
            return ()
        }
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { user, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.lastNameField.text! + " " + self.firstNameField.text!
                    changeRequest?.commitChanges(completion: nil)
                    

                    let userInfo: [String: Any] = ["email": self.emailField.text!,
                                                   "fullName": self.lastNameField.text! + " " + self.firstNameField.text!]
                    self.ref.child("users").childByAutoId().setValue(userInfo)
                }
            })
        
        self.performSegue(withIdentifier: "backToLoginView", sender: nil)
    }
}
