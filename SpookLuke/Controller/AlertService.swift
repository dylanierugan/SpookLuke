//
//  AlertService.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/27/21.
//

import Foundation
import UIKit
import RealmSwift

// Used for ListViewController
class AlertService {
    private init() {}
    
    static func addAlert<T: DataProtocol>(in vc: UIViewController, table: UITableView, object: T) {
        // alert asking to add data
        
        let alert = UIAlertController(title: "Add New Data", message: "", preferredStyle: .alert)
        var textFieldOne = UITextField()
        var textFieldTwo = UITextField()
        var textFieldThree = UITextField()
        
        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in
            // check that entries are numerical and that entry one is not empty
            let entryOneString = textFieldOne.text!
            let entryTwoString = textFieldTwo.text!
            let entryThreeString = textFieldThree.text!
            
            if entryOneString.count > 3 && entryTwoString.count > 3 && entryThreeString.count > 3 { // check that inputs are less 4 characters
                let alert = UIAlertController(title: "Error", message: "Please enter values with 3 numbers or less.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                vc.present(alert, animated: true)
            } else if object.numberOfEntries == 1 && entryTwoString.isInt { // two entries
                // input both entries to object and save
                object.entryTwoInt = Int(entryTwoString)!
                RealmService.shared.save(object,table: table)
            // check that entry one is empty, indicating a single entry
            } else if object.numberOfEntries == 2 && entryOneString.isInt && entryTwoString.isInt {  // one entry
                // input one entry to object and save
                object.entryOneInt = Int(entryOneString)!
                object.entryTwoInt = Int(entryTwoString)!
                RealmService.shared.save(object, table: table)
            } else if object.numberOfEntries == 3 && entryOneString.isInt && entryTwoString.isInt && entryThreeString.isInt {
                object.entryOneInt = Int(entryOneString)!
                object.entryTwoInt = Int(entryTwoString)!
                object.entryThreeInt = Int(entryThreeString)!
                RealmService.shared.save(object, table: table)
            } else {
                let alert = UIAlertController(title: "Error", message: "Please input numerical values.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                vc.present(alert, animated: true)
            }
        }
        
        if object.numberOfEntries == 1 { // add alert for 1 entry
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
                textFieldTwo.keyboardType = UIKeyboardType.numberPad
            }
        } else if object.numberOfEntries == 2 { // add alert for 2 entry
            alert.addTextField { (field) in
                textFieldOne = field
                textFieldOne.placeholder = "\(object.entryOneString):"
            }
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
            }
            textFieldOne.keyboardType = UIKeyboardType.numberPad
            textFieldTwo.keyboardType = UIKeyboardType.numberPad
        } else if object.numberOfEntries == 3 { // add alert for 3 entry
            alert.addTextField { (field) in
                textFieldOne = field
                textFieldOne.placeholder = "\(object.entryOneString):"
            }
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
            }
            alert.addTextField { (field) in
                textFieldThree = field
                textFieldThree.placeholder = "\(object.entryThreeString):"
            }
            textFieldOne.keyboardType = UIKeyboardType.numberPad
            textFieldTwo.keyboardType = UIKeyboardType.numberPad
            textFieldThree.keyboardType = UIKeyboardType.numberPad
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func updateAlert<T: DataProtocol>(in vc: UIViewController, table: UITableView, object: T, index: Int) {
        // update data alert
        
        let alert = UIAlertController(title: "Update Data", message: nil, preferredStyle: .alert)
        var textFieldOne = UITextField()
        var textFieldTwo = UITextField()
        var textFieldThree = UITextField()
        textFieldOne.keyboardType = UIKeyboardType.numberPad
        textFieldTwo.keyboardType = UIKeyboardType.numberPad
        textFieldThree.keyboardType = UIKeyboardType.numberPad
        let action = UIAlertAction.init(title: "Update", style: .default) { (action) in
            let entryOneString = textFieldOne.text!
            let entryTwoString = textFieldTwo.text!
            let entryThreeString = textFieldThree.text!
            
            // check that entries are numerical
            if entryOneString.count > 3 && entryTwoString.count > 3 && entryThreeString.count > 3 { // check that inputs are less 4 characters
                let alert = UIAlertController(title: "Error", message: "Please enter values with 3 numbers or less.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                vc.present(alert, animated: true)
            } else if object.numberOfEntries == 1 && entryTwoString.isInt { // update 1 entry
                RealmService.shared.updateOneField(object: object, index: index, entryOne: entryOneString, entryTwo: entryTwoString, entryThree: entryThreeString,table: table)
            } else if object.numberOfEntries == 2 && entryOneString.isInt && entryTwoString.isInt { // update 2 entries
                
                RealmService.shared.updateOneField(object: object, index: index, entryOne: entryOneString, entryTwo: entryTwoString, entryThree: entryThreeString,table: table)
            } else if object.numberOfEntries == 3 && entryOneString.isInt && entryTwoString.isInt && entryThreeString.isInt { // update 3 entries
                RealmService.shared.updateOneField(object: object, index: index, entryOne: entryOneString, entryTwo: entryTwoString, entryThree: entryThreeString,table: table)
            } else {
                let alert = UIAlertController(title: "Error", message: "Please input numerical values.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                vc.present(alert, animated: true)
            }
        }
        
        if object.numberOfEntries == 1 { // update alert for 1 entry
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
                textFieldOne.keyboardType = UIKeyboardType.numberPad
            }
        } else if object.numberOfEntries == 2 { // update alert for 2 entries
            alert.addTextField { (field) in
                textFieldOne = field
                textFieldOne.placeholder = "\(object.entryOneString):"
            }
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
                textFieldOne.keyboardType = UIKeyboardType.numberPad
                textFieldTwo.keyboardType = UIKeyboardType.numberPad
            }
        } else if object.numberOfEntries == 3 { // update alert for 3 entries
            alert.addTextField { (field) in
                textFieldOne = field
                textFieldOne.placeholder = "\(object.entryOneString):"
            }
            alert.addTextField { (field) in
                textFieldTwo = field
                textFieldTwo.placeholder = "\(object.entryTwoString):"
            }
            alert.addTextField { (field) in
                textFieldThree = field
                textFieldThree.placeholder = "\(object.entryThreeString):"
            }
            textFieldOne.keyboardType = UIKeyboardType.numberPad
            textFieldTwo.keyboardType = UIKeyboardType.numberPad
            textFieldThree.keyboardType = UIKeyboardType.numberPad
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }

}
