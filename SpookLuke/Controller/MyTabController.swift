//
//  MyTabController.swift
//  SpookLuke
//
//  Created by Duncan Champney on 12/17/17.
//  Copyright © 2017 Duncan Champney. All rights reserved.
//  https://github.com/DuncanMC/TabBarControllers/tree/master/TabBarControllers
//
//  Used to switch tabs programatically.

import UIKit

class MyTabController: UITabBarController, TabController {
    
    override var selectedIndex: Int {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tabs = viewControllers else { return }
        for aVC in tabs {
            if let aTab = aVC as? ATabController {
                aTab.tabDelegate = self
            }
        }
    }
    
    // The prepare(for:) method gets called as the Storyboard adds child view controllers to the tab bar controller.
    // By implementing this function we can set up the tab bar controller as the `tabDelegate`
    // of each child view controller so they are able to ask the tab bar controller to change tabs.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let child = segue.destination as? ATabController {
            child.tabDelegate = self
        }
    }
    
    @objc func switchTab(to: Tab) {
        let index = to.rawValue
        guard let viewControllerCount = viewControllers?.count,
              index >= 0 && index < viewControllerCount  else { return }
        selectedIndex = index
    }
    
}
