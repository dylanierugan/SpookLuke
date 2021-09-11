//
//  TaskCell.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/14/21.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskBubble: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskBubble.layer.cornerRadius = taskBubble.frame.size.height / 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTask(task: Task) {
        cellLabel.text = task.taskName
    }
    
}

