//
//  ArticleTableViewController.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit
import Firebase

class ArticleTableViewController: UITableViewController {

    let ref = Database.database().reference(withPath: "article-items")
    
    
    var items: [ArtileItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableView.automaticDimension
        // if there is no comments, no lines
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        
        
        // 回收 value 的值：
        ref.observe(.value, with: { snapshot in
//            print(snapshot.value as Any)
            // 再傳至 tableViewCell
            var newItems: [ArtileItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let articleItem = ArtileItem(snapshot: snapshot) {
                  newItems.append(articleItem)
                }
              }
            self.items = newItems
            self.tableView.reloadData()
        })

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // removeItem
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
      if editingStyle == .delete {
        let articleItem = items[indexPath.row]
        articleItem.ref?.removeValue()
      }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
      var articleItem = items[indexPath.row]
      let toggledCompletion = !articleItem.completed
        
        toggleCellCheckbox(cell as! TableViewCell, isCompleted: toggledCompletion)

        articleItem.ref?.updateChildValues([
          "completed": toggledCompletion
      ])
    }
    
    func toggleCellCheckbox(_ cell: TableViewCell, isCompleted: Bool) {
      if !isCompleted {
        cell.likedBtn.tintColor = .systemGray
      } else {
        cell.likedBtn.tintColor = .red
      }
    }
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? TableViewCell {
            var articleItem = self.items[indexPath.row]
        
            cell.cellName.text = articleItem.lastName + " " + articleItem.firstName
            cell.cellDate.text = articleItem.date
            cell.cellTitle.text = articleItem.title
            cell.cellLable.text = articleItem.content
            
            return cell
        } else {
            let somecell: UITableViewCell = UITableViewCell()
            return somecell
        }
    }
    
    @IBAction func LogoutToLoginView(_ sender: Any) {
        // want it to log out and delete the data
        do {
            try Auth.auth().signOut()
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    
    @IBAction func unwindSegueBack(segue: UIStoryboardSegue) {
    }
    
    
}
