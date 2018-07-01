//
//  User.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class User: NSObject {
    var idx = 0
    var strUdid = ""
    var strEmail = ""
    var strPass = ""
    var strPhone = ""
    var strCity = ""
    var strTownship = ""
    var strFBID = ""
    var strFBName = ""
    var strReferCode = ""
    
    var linked = 0
    var login_type = 0
    var city_idx = 0
    var township_idx = 0
    
    class func getCurrentAuth() -> User {
        let user = User()
        
        let prefs = UserDefaults.standard
        
        if let strFBID = prefs.rm_customObject(forKey: StringTable.PREF_FBID) as? String {
            user.strFBID = strFBID
        }
        if let strFBName = prefs.rm_customObject(forKey: StringTable.PREF_FBNAME) as? String {
            user.strFBName = strFBName
        }
        if let strPhone = prefs.rm_customObject(forKey: StringTable.PREF_PHONE) as? String {
            user.strPhone = strPhone
        }
        
        return user
    }
    
    class func setCurrentAuth(_ user: User) {
        let prefs = UserDefaults.standard
        prefs.rm_setCustomObject(user.strFBID, forKey: StringTable.PREF_FBID)
        prefs.rm_setCustomObject(user.strFBName, forKey: StringTable.PREF_FBNAME)
        prefs.rm_setCustomObject(user.strPhone, forKey: StringTable.PREF_PHONE)
    }
    
}
