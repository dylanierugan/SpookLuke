//
//  NoteCellTableViewCell.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/4/21.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    func configure(titleText: String) {
        title.text = titleText
    }
}
