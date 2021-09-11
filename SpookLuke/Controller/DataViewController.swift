//
//  DataViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/13/21.
//

import UIKit
import RealmSwift

class DataViewController: ATabController, UIPageViewControllerDelegate {
    
// MARK: - Outlets
    
    @IBOutlet weak var DC2OverhaulButton: UIButton!
    @IBOutlet weak var lethsRingsButton: UIButton!
    @IBOutlet weak var aimTrainingButton: UIButton!
    @IBOutlet weak var rankedButton: UIButton!
    @IBOutlet weak var recoveryButton: UIButton!
    
// MARK: - Variables
    
    var buttonTitle: String?
    var dataEntries: Int?
    var dataObject : Object?

// MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DC2OverhaulButton.layer.cornerRadius = 15
        DC2OverhaulButton.titleLabel?.textAlignment = .center
        lethsRingsButton.layer.cornerRadius = 15
        lethsRingsButton.titleLabel?.textAlignment = .center
        aimTrainingButton.layer.cornerRadius = 15
        aimTrainingButton.titleLabel?.textAlignment = .center
        rankedButton.layer.cornerRadius = 15
        rankedButton.titleLabel?.textAlignment = .center
        recoveryButton.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
    }

// MARK: - Button Actions
    
    @IBAction func DC2OverhaulButtonPressed(_ sender: UIButton) {
        buttonTitle = DC2OverhaulButton.titleLabel!.text
        dataObject = DC2OverhaulData()
        performSegue(withIdentifier: "dataToList", sender: self)
    }
    
    @IBAction func lethsRingsButtonPressed(_ sender: UIButton) {
        buttonTitle = lethsRingsButton.titleLabel!.text
        dataObject = LethsRingsData()
        performSegue(withIdentifier: "dataToList", sender: self)
    }
    
    @IBAction func aimTrainingButtonPressed(_ sender: UIButton) {
        buttonTitle = aimTrainingButton.titleLabel!.text
        dataObject = AimTrainingData()
        performSegue(withIdentifier: "dataToList", sender: self)
    }
    
    @IBAction func ranked1v1ButtonPressed(_ sender: UIButton) {
        buttonTitle = rankedButton.titleLabel!.text
        dataObject = RankedData()
        performSegue(withIdentifier: "dataToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue to task page
        if segue.identifier == "dataToList" {
            let dataVC = segue.destination as! ListViewController
            dataVC.dataDelegate = self
            dataVC.listTitle = buttonTitle
            dataVC.dataObject = dataObject
        } else if segue.identifier == "dataToNotes" {
            
        }
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        DC2OverhaulButton.sendActions(for: .touchUpInside)
    }
    
    
}
