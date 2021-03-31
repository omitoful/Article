//
//  ViewController.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "LoginToList", sender: nil)
                self.textFieldLoginEmail.text = self.textFieldLoginEmail.text
                self.textFieldLoginPassword.text = nil
            }
        }
    }
    @IBAction func LoginDidTouch(_ sender: AnyObject) {
        
        guard let email = textFieldLoginEmail.text,
              let password = textFieldLoginPassword.text,
              email.count > 0,
              password.count > 0
        else {
            print("???")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                print("login")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func SignUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!, password: self.textFieldLoginPassword.text!)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindSegueBackToLogin(segue: UIStoryboardSegue) {
    }
    
}

//extension LoginViewController: UITextFieldDelegate {
//
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    if textField == textFieldLoginEmail {
//      textFieldLoginPassword.becomeFirstResponder()
//    }
//    if textField == textFieldLoginPassword {
//      textField.resignFirstResponder()
//    }
//    return true
//  }
//}
