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
    var likes: Int
    let userID: String
    let userEmail: String
    let userName: String
    let postID: String
    let peopleWhoLike: [String]

    init(title: String, content: String, date: String, likes: Int, userID: String, userEmail: String, userName: String, postID: String, peopleWhoLike: [String]) {
        self.ref = nil
        self.title = title
        self.content = content
        self.date = date
        self.likes = likes
        self.userID = userID
        self.userEmail = userEmail
        self.userName = userName
        self.postID = postID
        self.peopleWhoLike = peopleWhoLike
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
        guard let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let content = value["content"] as? String,
            let date = value["date"] as? String,
            let likes = value["likes"] as? Int,
            let userID = value["userID"] as? String,
            let userEmail = value["userEmail"] as? String,
            let userName = value["userName"] as? String,
            let postID = value["postID"] as? String,
            let peopleWhoLike = value["peopleWhoLike"] as? [String]
            else {
            return nil
            }
        self.ref = snapshot.ref
        self.title = title
        self.content = content
        self.date = date
        self.likes = likes
        self.userID = userID
        self.userEmail = userEmail
        self.userName = userName
        self.postID = postID
        self.peopleWhoLike = peopleWhoLike
    }
    
    func toAnyObject() -> Any {
      return [
        "date": date,
        "title": title,
        "content": content,
        "likes": likes,
        "userID": userID,
        "userEmail": userEmail,
        "userName": userName,
        "postID": postID,
        "peopleWhoLike": peopleWhoLike
      ]
    }

}
