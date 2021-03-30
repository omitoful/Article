//
//  TableViewCell.swift
//  Article
//
//  Created by 陳冠甫 on 2021/3/30.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellLable.textAlignment = .left
        
        cellLable.numberOfLines = 0
    }

}
