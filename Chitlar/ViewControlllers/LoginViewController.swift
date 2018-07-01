//
//  ViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import SVProgressHUD

class LoginViewController: UIViewController {
    
    var loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
    
    var fb_email = ""
    var fb_name = ""
    var fb_id = ""
    var fb_photo_url = ""
    
    var sync_count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpFBLoginButton()
    }
    
    func setUpFBLoginButton() {
        self.loginButton.delegate = self
        
        self.loginButton.frame = CGRect(x: 50, y: view.frame.height / 2, width: view.frame.width - 100, height: loginButton.frame.height + 20)
        view.addSubview(self.loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertController(_ title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertControllerWithAction(_ title: String, withMessage message: String, response: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
            response(action)
        }
        
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // sync fb login
    func syncFBLogin() {
        //self.view.endEditing(true)

        SVProgressHUD.show()
        
        let params = ["name": self.fb_name, "id": self.fb_id, "birthdate": "14/06/1986", "gender": "male", "photo": self.fb_photo_url] as [String : AnyObject]
        print(params)
        
        let url = "\(APIStrings.baseUrl)\(APIStrings.loginUrl)"
        
        APIClient.shared.requestPOSTURL(url, params: params, headers: nil, success: {
            (response) -> Void in
            print(response)
            let dics = response as? NSDictionary
            let status = dics?["status"] as! String
            
            if status == "completed" {
                SVProgressHUD.dismiss()
                
                if let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav") as? UINavigationController{
                    self.present(navController, animated: true, completion: nil)
                }
            }
            
        }) {
            (error) -> Void in
            print(error)
            
            SVProgressHUD.dismiss()
            self.showAlertController(StringTable.APP_TITLE, withMessage: "There is an error in logging in to server. Please try again later.")
        }
    }

}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        //print("Did complete login via LoginButton with result \(result)")
        switch result {
        case .failed(let error):
            print(error)
            
            let loginManager = LoginManager()
            loginManager.logOut()
            
            let cookies = HTTPCookieStorage.shared
            let facebookCookies = cookies.cookies(for: URL(string: "https://facebook.com/")!)!
            
            for cookie in facebookCookies {
                cookies.deleteCookie(cookie as HTTPCookie)
            }
            
            self.showAlertController("Chitlar", withMessage: "There is an error with Facebook Login. Please try again later.")
            
        case .cancelled:
            print("Cancelled")
            
        case .success( _, _, _):
            print("Logged In")
            
            self.fb_email = ""
            self.fb_name = ""
            self.fb_id = ""
            self.fb_photo_url = ""
            
            let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"])
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    
                    let loginManager = LoginManager()
                    loginManager.logOut()
                    
                    let cookies = HTTPCookieStorage.shared
                    let facebookCookies = cookies.cookies(for: URL(string: "https://facebook.com/")!)!
                    
                    for cookie in facebookCookies {
                        cookies.deleteCookie(cookie as HTTPCookie)
                    }
                    
                    self.showAlertController("Chitlar", withMessage: "There is an error with Facebook Login. Please try again later.")
                    
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        print(responseDictionary)
                        
                        if let id = responseDictionary["id"] {
                            self.fb_id = id as! String
                        }
                        
                        if let name = responseDictionary["name"] {
                            self.fb_name = name as! String
                        }
                        
                        if let email = responseDictionary["email"] {
                            self.fb_email = email as! String
                        }
                        
                        if let picture = responseDictionary["picture"] as? NSDictionary {
                            let data = picture["data"] as! NSDictionary
                            self.fb_photo_url = data["url"] as! String
                        }
                        
                        self.syncFBLogin()
                    }
                }
            }
            
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did logout via LoginButton")
    }
    
}

