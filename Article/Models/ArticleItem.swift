//
//  Articles.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import Foundation
import Firebase

struct ArtileItem {

    let ref: DatabaseReference?
    let title: String
    let content: String
    let date: String
    var completed: Bool
    let userID: String
    let userEmail: String
    let userName: String
    let postID: String

    init(title: String, content: String, date: String, completed: Bool, userID: String, userEmail: String, userName: String, postID: String) {
        self.ref = nil
        self.title = title
        self.content = content
        self.date = date
        self.completed = completed
        self.userID = userID
        self.userEmail = userEmail
        self.userName = userName
        self.postID = postID
    }
// easy to debug:
//    init(snapshot: DataSnapshot) throws {
//        guard
//            let value = snapshot.value as? [String: AnyObject]
//        else {
//            // define enum error.
//        }
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let title = value["title"] as? String,
//            let content = value["content"] as? String,
//            let firstName = value["firstName"] as? String,
//            let lastName = value["lastName"] as? String,
//            let date = value["date"] as? String,
//            let addedByUser = value["addByUser"] as? String,
//            let completed = value["completed"] as? Bool else {
//            return nil
//        }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let content = value["content"] as? String,
            let date = value["date"] as? String,
            let completed = value["completed"] as? Bool,
            let userID = value["userID"] as? String,
            let userEmail = value["userEmail"] as? String,
            let userName = value["userName"] as? String,
            let postID = value["postID"] as? String else {
            return nil
        }
        self.ref = snapshot.ref
        self.title = title
        self.content = content
        self.date = date
        self.completed = completed
        self.userID = userID
        self.userEmail = userEmail
        self.userName = userName
        self.postID = postID
    }
    
    func toAnyObject() -> Any {
      return [
        "date": date,
        "title": title,
        "content": content,
        "completed": completed,
        "userID": userID,
        "userEmail": userEmail,
        "userName": userName,
        "postID": postID
      ]
    }

}
