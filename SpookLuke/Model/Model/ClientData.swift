//
//  ClientData.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/11/21.
//

import Foundation
import RealmSwift

class ClientData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 1 // in days
}
