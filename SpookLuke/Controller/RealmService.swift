//
//  RealmService.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/27/21.
//

import Foundation
import RealmSwift

// Used for ListViewController
class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    // save in Realm
    func save<T: Object>(_ object: T, table: UITableView) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saving data, \(error)")
        }
        table.reloadData()
    }
    
    // delete in Realm
    func delete<T: Object>(_ object: T, table: UITableView) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting data, \(error)")
        }
        table.reloadData()
    }
    
    func updateOneField<T: DataProtocol>(object: T, index: Int, entryOne: String, entryTwo: String, entryThree: String,table: UITableView) {
        // if object only has one entry
        if object.numberOfEntries == 1 {
            do {
                try realm.write {
                    object.entryTwoInt = Int(entryTwo)! // entry two fills bottom space
                }
            } catch {
                print("Error updating data, \(error)")
            }
        } else if object.numberOfEntries == 2 { // if object has two entries
            do {
                try realm.write {
                    object.entryOneInt = Int(entryOne)!
                    object.entryTwoInt = Int(entryTwo)!
                }
            } catch {
                print("Error updating data, \(error)")
            }
        } else if object.numberOfEntries == 3 {
            do {
                try realm.write {
                    object.entryOneInt = Int(entryOne)!
                    object.entryTwoInt = Int(entryTwo)!
                    object.entryThreeInt = Int(entryThree)!
                }
            } catch {
                print("Error updating data, \(error)")
            }
        }
        table.reloadData()
    }
    
    // load data to list
    func loadData<T: Object>(list: inout Results<T>?, object: T.Type, table: UITableView) {
        list = realm.objects(object.self) // look in realm and fetch all objects in category data type
        table.reloadData()
    }
 
}
