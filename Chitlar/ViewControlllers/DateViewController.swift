//
//  DateViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 7/1/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(235/255.0), green: CGFloat(38/255.0), blue: CGFloat(239/255.0), alpha: CGFloat(1.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier :"date_plan") as! DatePlanViewController
        if sender.tag == 0 {
            viewController.strTime = "Friday evening (5-7pm)"
        }
        else if sender.tag == 1 {
            viewController.strTime = "Saturday morning (9-11am)"
        }
        else if sender.tag == 2 {
            viewController.strTime = "Saturday lunchtime (1-3pm)"
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
