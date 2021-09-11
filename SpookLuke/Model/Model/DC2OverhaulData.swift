//
//  DC2OverhaulData.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/26/21.
//

import Foundation
import RealmSwift

class DC2OverhaulData : Object {
    @objc dynamic var levels : Int = 0
    @objc dynamic var deaths : Int = 0
    
    convenience required init(levels: Int, deaths: Int) {
        self.init()
        self.levels = levels
        self.deaths = deaths
    }
    
    func dataToString(data:Int) -> String {
        return 
    }
    
}
