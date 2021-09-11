//
//  infoViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 8/24/21.
//

import UIKit

class InfoViewController: UIViewController {

// MARK: - Outlets and Variables
    
    @IBOutlet weak var membershipButton: UIButton!
    @IBOutlet weak var youTubeButton: UIButton!
    @IBOutlet weak var dreamyButton: UIButton!
    @IBOutlet weak var curtisButton: UIButton!

// MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        membershipButton.layer.cornerRadius = 15
        youTubeButton.layer.cornerRadius = 15
        dreamyButton.layer.cornerRadius = 15
        curtisButton.layer.cornerRadius = 15
    }
    
// MARK: - Link Buttons
    
    @IBAction func membershipButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://www.spookluke.com/membership-site1621527816773?page_id=48632467&page_key=7qqnor70idl9ep0q&login_redirect=1") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func youTubeButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://www.youtube.com/channel/UCfzjoVrSU7K5zUR4FaBLx3A") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func dreamyButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://calendly.com/dreamy/30min") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func curtisButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://calendly.com/rlcs_curtis/replay-analysis-w-coach-curtis") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
}
