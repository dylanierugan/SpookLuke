//
//  EntryViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/3/21.
//

import UIKit

class EntryViewController: UIViewController {
// create note
    
// MARK: - Variables
    var entryNumber: Int?
    var notesTable: UITableView?
    
// MARK: - Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet var noteField: UITextView!
    
// MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard() //call to keyboard handling
        noteField.becomeFirstResponder()
        navigationBar.topItem!.title = "Day \(entryNumber ?? -1)"
        noteField.layer.cornerRadius = 5
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let newNote = noteField.text
        let newNoteObject = RecoveryTrainingData()
        newNoteObject.note = newNote!
        do {
            try realm.write {
                realm.add(newNoteObject)
            }
        } catch {
            print("Error saving data, \(error)")
        }
        self.dismiss(animated: true, completion: {})
        notesTable?.reloadData()
    }
}
