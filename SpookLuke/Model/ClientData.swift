//
//  clientData.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/26/21.
//

import Foundation
import RealmSwift

// client object
class ClientData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var currentPhase: Int = 0
    @objc dynamic var currentDay: String = ""
    @objc dynamic var phaseOneDaysCompleted: Int = 0
    @objc dynamic var phaseTwoDaysCompleted: Int = 0
    @objc dynamic var phaseThreeDaysCompleted: Int = 0
}
