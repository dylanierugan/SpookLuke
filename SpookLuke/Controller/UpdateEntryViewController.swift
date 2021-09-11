//
//  ViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/4/21.
//

import UIKit

class UpdateEntryViewController: UIViewController {
// update note

// MARK: - Variables
    @IBOutlet weak var noteField: UITextView!
    
    var note: String?
    var notesTable: UITableView?
    var noteToBeUpdated: RecoveryTrainingData?
    
// MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard() //call to keyboard handling
        noteField.text = note!
        noteField.layer.cornerRadius = 5
    }
    
// MARK: - Action
    @IBAction func updateButtonPressed(_ sender: Any) {
        do {
            try realm.write {
                noteToBeUpdated?.note = noteField.text
            }
        } catch {
            print("Error updating data, \(error)")
        }
        self.dismiss(animated: true, completion: {})
        notesTable?.reloadData()
    }
}
