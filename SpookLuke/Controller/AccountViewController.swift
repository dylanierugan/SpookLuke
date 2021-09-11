//
//  accountViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/24/21.
//

import UIKit

class AccountViewController: UIViewController {

// MARK: - Outlets and Variables
    
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var resetProgressButton: UIButton!
    @IBOutlet weak var resetDataButton: UIButton!
    @IBOutlet weak var resetAllButton: UIButton!
    
    let defaults = UserDefaults.standard
    
// MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeNameButton.layer.cornerRadius = 15
        resetProgressButton.layer.cornerRadius = 15
        resetDataButton.layer.cornerRadius = 15
        resetAllButton.layer.cornerRadius = 15
    }
    
// MARK: - Actions
    
    @IBAction func changeNameButtonPressed(_ sender: UIButton) {
        let changeAlert = UIAlertController(title: "Update Name", message: nil, preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction.init(title: "Update", style: .default) { (action) in
            if textField.text!.count <= 10 && textField.text! != "" {
                let newName = textField.text!
                let client = realm.objects(ClientData.self)
                do {
                    try realm.write {
                        client[0].name = newName
                    }
                } catch {
                    print("Error updating client name, \(error)")
                }
                NotificationCenter.default.post(name: .name, object: nil)
                let alert = UIAlertController(title: "", message: "Name changed successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            } else if textField.text!.count > 10 {
                let alert = UIAlertController(title: "Error", message: "New name too long.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            } else if textField.text! == "" {
                let alert = UIAlertController(title: "Error", message: "No name entered.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    // cancel - do nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            // cancel - do nothing
        }
        changeAlert.addTextField { (field) in
            textField = field
            textField.placeholder = "New Name:"
        }
        changeAlert.addAction(cancelAction)
        changeAlert.addAction(action)
        present(changeAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetProgressButtonPressed(_ sender: UIButton) {
        // resets task progress only
        let resetProgressAlert = UIAlertController(title: "Are you sure you want to reset progress?", message: "This will only reset progress data in the home page and will not erase data in the data tab.", preferredStyle: UIAlertController.Style.alert)
        resetProgressAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            // cancel - do nothing
        }))
        resetProgressAlert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { [self] (action: UIAlertAction!) in
            // reset - make user default false and delete data from Realm
            self.defaults.set(false, forKey: "userRegistered")
            let client = realm.objects(ClientData.self)
            let tasks = realm.objects(Task.self)
            do {
                try realm.write {
                    realm.delete(client)
                    realm.delete(tasks)
                    defaults.set(false, forKey: "inRealm")
                    defaults.set(0, forKey: "tasksCompleted")
                    defaults.set(0, forKey: "totalTasksCompleted")
                }
            } catch {
                print("Error deleting all data: \(error)")
            }
            newNotification.center.removePendingNotificationRequests(withIdentifiers: [newNotification.uuid]) // kill notification
            let alert = UIAlertController(title: "", message: "Progress successfully deleted.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.performSegue(withIdentifier: "settingsToName", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }))
        present(resetProgressAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetDataButtonPressed(_ sender: UIButton) {
        // reset data only
        let resetDataAlert = UIAlertController(title: "Are you sure you want to erase data?" , message:  "This will only erase data and notes tracked in the data tab and will not reset progress in the home tab.", preferredStyle: UIAlertController.Style.alert)
        resetDataAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            // cancel - do nothing
        }))
        resetDataAlert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { (action: UIAlertAction!) in
            // delete data
            let DC2Data = realm.objects(DC2OverhaulData.self)
            let lethsRingsData = realm.objects(LethsRingsData.self)
            let aimTrainingData = realm.objects(AimTrainingData.self)
            let rankedData = realm.objects(RankedData.self)
            let recoveryTrainingData = realm.objects(RecoveryTrainingData.self)
            do {
                try realm.write {
                    realm.delete(DC2Data)
                    realm.delete(lethsRingsData)
                    realm.delete(aimTrainingData)
                    realm.delete(rankedData)
                    realm.delete(recoveryTrainingData)
                }
            } catch {
                print("Error deleting all data: \(error)")
            }
            let alert = UIAlertController(title: "", message: "Data successfully deleted.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            self.present(alert, animated: true, completion: nil)
        }))
        present(resetDataAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetAllButtonPrssed(_ sender: UIButton) {
        // reset everything
        let resetAlert = UIAlertController(title: "Are you sure you want to reset?", message: "This will erase all data.", preferredStyle: UIAlertController.Style.alert)
        resetAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            // cancel - do nothing
        }))
        resetAlert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { [self] (action: UIAlertAction!) in
            // reset - make user default false and delete data from Realm
            self.defaults.set(false, forKey: "userRegistered")
            let client = realm.objects(ClientData.self)
            let tasks = realm.objects(Task.self)
            let DC2Data = realm.objects(DC2OverhaulData.self)
            let lethsRingsData = realm.objects(LethsRingsData.self)
            let aimTrainingData = realm.objects(AimTrainingData.self)
            let rankedData = realm.objects(RankedData.self)
            let recoveryTrainingData = realm.objects(RecoveryTrainingData.self)
            do {
                try realm.write {
                    realm.delete(client)
                    realm.delete(tasks)
                    realm.delete(DC2Data)
                    realm.delete(lethsRingsData)
                    realm.delete(aimTrainingData)
                    realm.delete(rankedData)
                    realm.delete(recoveryTrainingData)
                    defaults.set(false, forKey: "inRealm")
                    defaults.set(0, forKey: "tasksCompleted")
                    defaults.set(0, forKey: "totalTasksCompleted")
                }
            } catch {
                print("Error deleting all data: \(error)")
            }
            newNotification.center.removePendingNotificationRequests(withIdentifiers: [newNotification.uuid]) // kill notification
            // go back to name page
            performSegue(withIdentifier: "settingsToName", sender: self)
        }))
        present(resetAlert, animated: true, completion: nil)
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }  
}
