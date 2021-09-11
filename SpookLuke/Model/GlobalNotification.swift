//
//  GlobalNotification.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/29/21.
//

import Foundation
import UserNotifications

// Notification struct created to keep a global notification variable that can be killed from anywhere

struct GlobalNotification {
    let center = UNUserNotificationCenter.current()
    var content = UNMutableNotificationContent()
    var trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((1)), repeats: false)
    var uuid = ""
}

var newNotification = GlobalNotification()
