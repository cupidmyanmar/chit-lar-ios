//
//  InfoViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 7/1/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class QuestionTwoViewController: UIViewController {

    @IBOutlet var txtView: UITextView!
    @IBOutlet var txtAge: UITextField!
    
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

    @IBAction func nextClick(_ sender: UIButton) {
        if let yourself = txtView.text, let age = txtAge.text, yourself.count > 0, age.count > 0 {
            UserDefaults.standard.set(yourself, forKey: "yourself")
            UserDefaults.standard.set(age, forKey: "age")
            let vc = self.storyboard?.instantiateViewController(withIdentifier :"info") as! InfoViewController
            vc.fromQuestion = true
            self.present(vc, animated: false, completion: nil)
        }
    }

}
