//
//  DatePlanViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 7/1/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class DatePlanViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var strTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedText = NSMutableAttributedString(string: strTime, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string: "\n\n\nGong Cha, Junction Square, Kamaryut", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nEarn points from checking in, taking a selfie together and finding the hidden items", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
