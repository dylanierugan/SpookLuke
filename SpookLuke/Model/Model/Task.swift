//
//  Task.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/14/21.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var taskName: String = ""
    @objc dynamic var time: Int = 0
    @objc dynamic var comepleted: Bool = false
    @objc dynamic var dataTrackingNeeded: Bool = false
    @objc dynamic var id: Int = 0
    
    convenience required init(taskName: String, time: Int, completed: Bool, dataTrackingNeeded: Bool, id: Int) {
        self.init()
        self.taskName = taskName
        self.time = time
        self.comepleted = comepleted
        self.dataTrackingNeeded = dataTrackingNeeded
        self.id = id
    }
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
}
