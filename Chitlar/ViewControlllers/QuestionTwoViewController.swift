//
//  QuestionTwoViewController.swift
//  Hack-a-thon
//
//  Created by Sanjay Arya on 7/1/18.
//  Copyright © 2018 Sanjay Arya. All rights reserved.
//

import UIKit

class QuestionTwoViewController: UIViewController {

    @IBOutlet var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
        UserDefaults.standard.set(txtView.text, forKey: "yourself")
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
