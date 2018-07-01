//
//  StringTable.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class StringTable: NSObject {
    
    static let APP_TITLE = "Chitlar"
    static let BUNDLE_ID = "com.bit.chitlar"
    
    static let IN_APP_1500 = "com.wunzinn.ipad.onefive"
    static let IN_APP_4500 = "com.wunzinn.ipad.fourfive"
    static let IN_APP_1700 = "com.wunzinn.ipad.oneseven"
    static let SUBSCRIPTION_BUNDLE_ID = "com.wunzinn.ipad.subscriptions"
    
    static let PREF_EMAIL = "WZ_EMAIL"
    static let PREF_FBID = "WZ_FBID"
    static let PREF_PASS = "WZ_PASS"
    static let PREF_FBNAME = "WZ_FBNAME"
    static let PREF_REFER_CODE = "WZ_REFER_CODE"
    static let PREF_LOGINTYPE = "WZ_LOGINTYPE"
    static let PREF_LINKED = "WZ_LINKED"
    static let PREF_PHONE = "WZ_PHONE"
    static let PREF_TOWNSHIP = "WZ_TW"
    static let PREF_UDID = "WZ_UDID"
    static let PREF_RENT = "WZ_RENT"
    
    static let KEY_FOR_LANGUAGE: String = "language"
    static let KEY_FOR_MM: String = "mm"
    static let KEY_FOR_EN: String = "en"
    
    static let ZAWGYI_FONT: String = "Zawgyi-One"
    
    static func checkTheLoginStatus() -> Bool {
        var isLogin = false
        
        isLogin = UserDefaults.standard.bool(forKey: "login")
        
        return isLogin
    }
    
    static func setLoginStatu() {
        let pref = UserDefaults.standard
        pref.set(true, forKey: "login")
    }
    
    // MARK: UserDefaults
    
    static func setUserLanguae(_ language: String) {
        let pref = UserDefaults.standard
        pref.set(language, forKey: KEY_FOR_LANGUAGE)
        pref.synchronize()
    }
    
    static func isMyanmarLanguage() -> Bool {
        let pref = UserDefaults.standard
        if let language = pref.string(forKey: KEY_FOR_LANGUAGE){
            if language == KEY_FOR_MM {
                return true
            }
        }
        else {
            setMyanmarLanuage()
            return true
        }
        return false
    }
    
    static func setMyanmarLanuage() {
        setUserLanguae(KEY_FOR_MM)
    }
    
    static func setEnglishLanuage() {
        setUserLanguae(KEY_FOR_EN)
    }
    
}
