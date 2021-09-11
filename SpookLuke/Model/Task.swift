//
//  Task.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/26/21.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var taskName: String = ""
    @objc dynamic var time: Int = 0
    @objc dynamic var comepleted: Bool = false
    @objc dynamic var dataTrackingNeeded: Bool = false
    @objc dynamic var numberOfEntries: Int = 0
    
    convenience required init(taskName: String, time: Int, completed: Bool, dataTrackingNeeded: Bool, numberOfEntries: Int) {
        self.init()
        self.taskName = taskName
        self.time = time
        self.comepleted = comepleted
        self.dataTrackingNeeded = dataTrackingNeeded
        self.numberOfEntries = numberOfEntries
    }
    
    
}
