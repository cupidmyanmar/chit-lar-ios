//
//  Person.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

//"id": "1814954288543852",
//"name": "Oak Soe Shein",
//"age": "32",
//"gender": "male",
//"photo": "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=1814954288543852&height=200&width=200&ext=1530612719&hash=AeRo3mqkjvTeZ54m",

import UIKit

class Person: NSObject {
    
    var uniq_id = ""
    var name = ""
    var age = ""
    var gender = ""
    var photo = ""
    var desc = ""
    
    class func getPersonFromDic(_ dic: NSDictionary) -> Person? {
        let item = Person()
        
        if let id = dic["id"] as? String {
            item.uniq_id = id
        }
        if let name = dic["name"] as? String {
            item.name = name
        }
        if let age = dic["age"] as? String {
            item.age = age
        }
        if let gender = dic["gender"] as? String {
            item.gender = gender
        }
        if let photo = dic["photo"] as? String {
            item.photo = photo
        }
        if let description = dic["description"] as? String {
            item.desc = description
        }
        
        return item
    }
    
}
