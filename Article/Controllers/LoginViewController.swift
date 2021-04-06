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
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "LoginToList", sender: nil)
                self.textFieldLoginEmail.text = nil
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
            let alert = UIAlertController(title: "Sign In Failed",message: "Check again",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return ()
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func SignUpDidTouch(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "tapToSignin", sender: nil)
    }
    
    
    @IBAction func unwindSegueBackToLogin(segue: UIStoryboardSegue) {
    }
    @IBAction func unwindSegueBacktoLoginView(segue: UIStoryboardSegue) {
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
