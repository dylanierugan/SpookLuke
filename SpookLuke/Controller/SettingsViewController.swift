//
//  SettingsViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/13/21.
//

import UIKit
import RealmSwift
import UserNotifications

class SettingsViewController: ATabController {
    
// MARK: - Outlets and Variables
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!

// MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoButton.layer.cornerRadius = 15
        accountButton.layer.cornerRadius = 15
        helpButton.layer.cornerRadius = 15
    }
// MARK: - Button Action
    
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsToInfo", sender: self)
    }
    
    @IBAction func accountButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsToAccount", sender: self)
    }
    
    @IBAction func helpButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://discord.gg/jZ2DR3kzXX") {
            UIApplication.shared.open(url)
        }
    }
    
}
