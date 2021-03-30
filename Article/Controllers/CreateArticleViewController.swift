//
//  CreateArticleViewController.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit
import Firebase

class CreateArticleViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "article-items")
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveDidtouch(_ sender: Any) {
        
        let title = titleField.text
        let content = contentField.text
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let date = dateField.text
        
        let articleItem = ArtileItem(title: title!, content: content!, firstName: firstName!, lastName: lastName!, date: date!, completed: false)

        if title!.count > 0, firstName!.count > 0, lastName!.count > 0, date!.count > 0 {
            let articleItemRef = self.ref.child("article: \(self.titleField.text!)")
            articleItemRef.setValue(articleItem.toAnyObject())
            
            self.titleField.text = nil
            self.firstNameField.text = nil
            self.lastNameField.text = nil
            self.dateField.text = nil
            self.contentField.text = "Write Somthing..."
        } else {
            self.contentField.text = "Please fill the info."
        }
    }
    
}
