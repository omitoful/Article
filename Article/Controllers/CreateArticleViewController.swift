//
//  CreateArticleViewController.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit
import Firebase

class CreateArticleViewController: UIViewController {
    
    let ref = Database.database().reference()
    var user = Auth.auth().currentUser!
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveDidtouch(_ sender: Any) {
        
        let title = titleField.text
        let content = contentField.text
        let date = dateField.text

        if title!.count > 0, date!.count > 0 {
            
            if let key = ref.child("posts").childByAutoId().key {
                
                let articleItem = ArtileItem(title: title!, content: content!, date: date!, likes: 0, userID: user.uid, userEmail: user.email!, userName: user.displayName!, postID: key, peopleWhoLike: [""])
                
//                let feed = ["userID": user.uid,
//                            "userEmail": user.email,
//                            "userName": user.displayName,
//                            "postID": key,
//                            "title": title,
//                            "date": date,
//                            "content": content]
                
//                let postFeed = ["\(key)": articleItem]
//                ref.child("posts").updateChildValues(postFeed)
                let articleItemRef = self.ref.child("posts")
                articleItemRef.child(key).setValue(articleItem.toAnyObject())
            }
            
            
            self.titleField.text = nil
            self.dateField.text = nil
            self.contentField.text = "Write Somthing..."
            // unwindSeage: 
            performSegue(withIdentifier: "backToArticle", sender: nil)
        } else {
            self.contentField.text = "Please fill the info."
        }
    }
    
}
