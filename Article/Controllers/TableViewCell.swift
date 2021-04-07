//
//  TableViewCell.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit
import Firebase

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellLable: UILabel!
    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var howManyLikes: UILabel!
    
    var postID: String!
    
    
    @IBAction func isToggle(_ sender: Any) {
        
        let ref = Database.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
        
        if likedBtn.tintColor == .systemGray {
            
            ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: { snapshot in
                if let post = snapshot.value as? [String: AnyObject] {
                    let updatelikes: [String: Any] = ["peopleWhoLike/\(keyToPost)": Auth.auth().currentUser!.uid]
                    ref.child("posts").child(self.postID).updateChildValues(updatelikes, withCompletionBlock: { (error, databaseRef) in
                        if error == nil {
                            ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                if let properties = snap.value as? [String: AnyObject] {
                                    if let likes = properties["peopleWhoLike"] as? [String: AnyObject] {
                                        let count = likes.count
                                        self.howManyLikes.text = "\(count) likes"
                                        
                                        let update = ["likes": count]
                                        ref.child("posts").child(self.postID).updateChildValues(update)
                                    }
                                }
                            })
                        }
                    })
                }
            })
            
            likedBtn.tintColor = .red
            ref.removeAllObservers()
            
        } else if likedBtn.tintColor == .red {
            ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: {snapshot in
                if let properties = snapshot.value as? [String: AnyObject] {
                    if let peopleWhoLike = properties["peopleWhoLike"] as? [String: AnyObject] {
                        for (id, person) in peopleWhoLike {
                            if person as? String == Auth.auth().currentUser!.uid {
                                ref.child("posts").child(self.postID).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, databaseRef) in
                                    if error == nil {
                                        ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                            if let prop = snap.value as? [String: AnyObject] {
                                                if let likes = prop["peopleWhoLike"] as? [String: AnyObject] {
                                                    let count = likes.count
                                                    self.howManyLikes.text = "\(count) likes"
                                                    
                                                    let update = ["likes": count]
                                                    ref.child("posts").child(self.postID).updateChildValues(update)
                                                } else {
                                                    
                                                    self.howManyLikes.text = "0 likes"
                                                    
                                                    let update = ["likes": 0]
                                                    ref.child("posts").child(self.postID).updateChildValues(update)
                                                }
                                            }
                                        })
                                    }
                                })
                            }
                        }
                    }
                }
            })
            likedBtn.tintColor = .systemGray
            ref.removeAllObservers()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellLable.textAlignment = .left
        
        cellLable.numberOfLines = 0
    }

}
