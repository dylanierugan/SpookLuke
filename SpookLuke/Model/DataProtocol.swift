//
//  DC2Overhaul.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/26/21.
//

import Foundation
import RealmSwift

// for storing user game data

protocol DataProtocol: Object {
    // every data abject will adhere to this protocol
    dynamic var entryOneString: String {get set}
    dynamic var entryTwoString: String {get set}
    dynamic var entryThreeString: String {get set}
    dynamic var entryOneInt: Int {get set}
    dynamic var entryTwoInt: Int {get set}
    dynamic var entryThreeInt: Int {get set}
    dynamic var numberOfEntries: Int {get set}
}

class DC2OverhaulData: Object, DataProtocol {
    @objc dynamic var entryOneString: String
    @objc dynamic var entryTwoString: String
    @objc dynamic var entryThreeString: String
    @objc dynamic var entryOneInt: Int
    @objc dynamic var entryTwoInt: Int
    @objc dynamic var entryThreeInt: Int
    @objc dynamic var numberOfEntries: Int
    override init() {
        entryOneString = "Levels"
        entryTwoString = "Deaths"
        entryThreeString = "Time (Minutes)"
        entryOneInt = 0
        entryTwoInt = 0
        entryThreeInt = 0
        numberOfEntries = 3
    }
}

class LethsRingsData: Object, DataProtocol {
    @objc dynamic var entryOneString: String
    @objc dynamic var entryTwoString: String
    @objc dynamic var entryThreeString: String
    @objc dynamic var entryOneInt: Int
    @objc dynamic var entryTwoInt: Int
    @objc dynamic var entryThreeInt: Int
    @objc dynamic var numberOfEntries: Int
    override init() {
        entryOneString = "Levels"
        entryTwoString = "Deaths"
        entryThreeString = "Time (Minutes)"
        entryOneInt = 0
        entryTwoInt = 0
        entryThreeInt = 0
        numberOfEntries = 3
    }
}

class AimTrainingData: Object, DataProtocol {
    @objc dynamic var entryOneString: String
    @objc dynamic var entryTwoString: String
    @objc dynamic var entryThreeString: String
    @objc dynamic var entryOneInt: Int
    @objc dynamic var entryTwoInt: Int
    @objc dynamic var entryThreeInt: Int
    @objc dynamic var numberOfEntries: Int
    override init() {
        entryOneString = ""
        entryTwoString = "Consecutive Shots Scored"
        entryThreeString = ""
        entryOneInt = 0
        entryTwoInt = 0
        entryThreeInt = 0
        numberOfEntries = 1
    }
}

class RankedData: Object, DataProtocol {
    @objc dynamic var entryOneString: String
    @objc dynamic var entryTwoString: String
    @objc dynamic var entryThreeString: String
    @objc dynamic var entryOneInt: Int
    @objc dynamic var entryTwoInt: Int
    @objc dynamic var entryThreeInt: Int
    @objc dynamic var numberOfEntries: Int
    override init() {
        entryOneString = "Goals Scored"
        entryTwoString = "Goals Conceded"
        entryThreeString = ""
        entryOneInt = 0
        entryTwoInt = 0
        entryThreeInt = 0
        numberOfEntries = 2
    }
}
