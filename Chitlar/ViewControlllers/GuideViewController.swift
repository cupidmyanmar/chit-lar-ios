//
//  GuideViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 7/1/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextClick(_ sender: UIButton) {
        if let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tab_bar") as? UITabBarController{
            self.present(navController, animated: true, completion: nil)
        }
    }

}
