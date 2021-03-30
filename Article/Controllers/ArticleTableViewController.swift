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
            print(snapshot.value as Any)
            // 再傳至 tableViewCell
            var newItem: [ArtileItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let articleItem = ArtileItem(snapshot: snapshot) {
                    newItem.append(articleItem)
                }
            }
            
            self.items = newItem
            self.tableView.reloadData()
        })

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? TableViewCell {
        let articleItem = self.items[indexPath.row]
        
            cell.cellName.text = articleItem.lastName + articleItem.firstName
            cell.cellDate.text = articleItem.date
            cell.cellTitle.text = articleItem.title
            cell.cellLable.text = articleItem.content


            return cell
        } else {
            let somecell: UITableViewCell = UITableViewCell()
            return somecell
        }
    }
}
