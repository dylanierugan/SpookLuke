//
//  DataCell.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/26/21.
//

import UIKit
import RealmSwift

class DataCell: UITableViewCell {
    
    // different cell configurations based on the number of data pieces needed

    @IBOutlet weak var entryOneLabel: UILabel!
    @IBOutlet weak var entryTwoLabel: UILabel!
    @IBOutlet weak var entryThreeLabel: UILabel!
    @IBOutlet weak var cellNumberLabel: UILabel!
    
    func configureOneEntry(data: DataProtocol, num: Int) {
        entryOneLabel.text = ""
        entryTwoLabel.text = "\(data.entryTwoString): \(data.entryTwoInt)"
        entryThreeLabel.text = ""
        cellNumberLabel.text = "Entry \(num + 1)"
    }
    
    func configureTwoEntries(data: DataProtocol, num: Int) {
        entryOneLabel.text = "\(data.entryOneString): \(data.entryOneInt)"
        entryTwoLabel.text = "\(data.entryTwoString): \(data.entryTwoInt)"
        entryThreeLabel.text = ""
        cellNumberLabel.text = "Entry \(num + 1)"
    }
    
    func configureThreeEntries(data: DataProtocol, num: Int) {
        entryOneLabel.text = "\(data.entryOneString): \(data.entryOneInt)"
        entryTwoLabel.text = "\(data.entryTwoString): \(data.entryTwoInt)"
        entryThreeLabel.text = "\(data.entryThreeString): \(data.entryThreeInt)"
        cellNumberLabel.text = "Entry \(num + 1)"
    }
}
