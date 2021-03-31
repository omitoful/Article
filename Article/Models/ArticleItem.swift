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
    let key: String
    let title: String
    let content: String
    let firstName: String
    let lastName: String
    let date: String
    let addedByUser: String
    var completed: Bool

    init(title: String, content: String, firstName: String, lastName: String, date: String, key: String = "", completed: Bool, addedByUser: String) {
        self.ref = nil
        self.title = title
        self.content = content
        self.firstName = firstName
        self.lastName = lastName
        self.date = date
        self.key = key
        self.completed = completed
        self.addedByUser = addedByUser
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
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let date = value["date"] as? String,
            let addedByUser = value["addBy"] as? String,
            let completed = value["completed"] as? Bool else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.title = title
        self.content = content
        self.firstName = firstName
        self.lastName = lastName
        self.date = date
        self.completed = completed
        self.addedByUser = addedByUser
    }
    
    func toAnyObject() -> Any {
      return [
        "firstName": firstName,
        "lastName": lastName,
        "date": date,
        "title": title,
        "content": content,
        "completed": completed,
        "addBy": addedByUser
      ]
    }

}
