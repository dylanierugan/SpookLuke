//
//  ViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/10/21.
//

import UIKit
import RealmSwift

class NameViewController: UIViewController, UITextFieldDelegate{
    
// MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pleaseEnterText: UILabel!
    
// MARK: - View Did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        
        initializeHideKeyboard()
        
        pleaseEnterText.isHidden = true
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.cornerRadius = nameTextField.frame.size.height/2
        nameTextField.clipsToBounds = false
        nameTextField.layer.shadowOpacity = 0.4
        nameTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
// MARK: - Actions
    
    @IBAction func textFieldContinuePressed(_ sender: UITextField) {
        // function iniates new client object and takes user to home page
        let name = nameTextField.text!
        
        if name != "" && name.count < 11 { // ensure name not empty and less than 11 characters
            let newClient = ClientData()
            newClient.name = name
            newClient.currentPhase = 0
            newClient.currentDay = "Ground Day"
            // add new client object to realm
            do {
                try realm.write{
                    realm.add(newClient)
                }
            } catch {
                print("Error saving name: \(error)")
            }
            // continue to home page
            performSegue(withIdentifier: "nameToHome", sender: self)
            newNotification.center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            }
        } else if name == "" { // name empty
            pleaseEnterText.text = "Please enter something."
            pleaseEnterText.isHidden = false
        } else if name.count > 10 { // name too long
            pleaseEnterText.text = "Enter a name shorter than 10 characters."
            pleaseEnterText.isHidden = false
        }
    }
}

// MARK: - Functionality for keyboard tap away

extension UIViewController {
    
    func initializeHideKeyboard() {
        // declare a tap gesture recognizer, triggers dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
            // add tap gesture recognizer to the parent view
            view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        // dismiss the active keyboard.
        view.endEditing(true)
    }
}
