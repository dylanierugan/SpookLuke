//
//  NotesViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/3/21.
//

import UIKit
import RealmSwift

class NotesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// MARK: - Variables
    
    @IBOutlet weak var notesTable: UITableView!
    
    var recoveryTrainingDataList: Results<RecoveryTrainingData> = realm.objects(RecoveryTrainingData.self)
    var rowNumber = 0

// MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.delegate = self
        notesTable.dataSource = self
        notesTable.rowHeight = 50
        // Do any additional setup after loading the view.
    }
    
// MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "noteToEntry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue to task page
        if segue.identifier == "noteToEntry" {
            let entryVC = segue.destination as! EntryViewController
            entryVC.entryNumber = recoveryTrainingDataList.count + 1
            entryVC.notesTable = notesTable
        } else if segue.identifier == "noteToUpdate" {
            let updateEntryVC = segue.destination as! UpdateEntryViewController
            updateEntryVC.notesTable = notesTable
            updateEntryVC.note = recoveryTrainingDataList[rowNumber].note
            updateEntryVC.noteToBeUpdated = recoveryTrainingDataList[rowNumber]
        }
    }
    
    
// MARK: - Table Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return cell count
        return recoveryTrainingDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // load cells
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else { return UITableViewCell() }
        cell.configure(titleText: "  Day \(indexPath.row + 1)")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // update note when selected
        tableView.deselectRow(at: indexPath, animated: true)
        rowNumber = indexPath.row
        performSegue(withIdentifier: "noteToUpdate", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // delete note
        guard editingStyle == .delete else { return }
        let noteToDelete = recoveryTrainingDataList[indexPath.row]
        do {
            try realm.write {
                realm.delete(noteToDelete)
            }
        } catch {
            print("Error deleting data, \(error)")
        }
        notesTable.reloadData()
    }
}
