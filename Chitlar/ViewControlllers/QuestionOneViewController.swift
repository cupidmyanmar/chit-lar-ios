//
//  ViewController.swift
//  Hack-a-thon
//
//  Created by Sanjay Arya on 6/30/18.
//  Copyright © 2018 Sanjay Arya. All rights reserved.
//

import UIKit

class QuestionOneViewController: UIViewController {

    @IBOutlet var interestedFemale: UIButton!
    @IBOutlet var interestedMale: UIButton!
    
    @IBOutlet var looking1: UIButton!
    @IBOutlet var looking2: UIButton!
    @IBOutlet var looking3: UIButton!
    
    @IBOutlet var budget1: UIButton!
    @IBOutlet var budget2: UIButton!
    @IBOutlet var budget3: UIButton!
    @IBOutlet var budget4: UIButton!
    
    var interest = false
    var looking = false
    var budget = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func interestedClick(_ sender: UIButton) {
        interestedMale.alpha = 0.5
        interestedFemale.alpha = 0.5
        
        sender.alpha = 1.0
        interest = true
        
        if sender.tag == 1 {
                UserDefaults.standard.set("interested in <b>women</b>", forKey: "interest")
        }else{
            UserDefaults.standard.set("interested in <b>men</b>", forKey: "interest")
        }
    }

    @IBAction func lookingClick(_ sender: UIButton) {
        looking1.setTitleColor(.white, for: .normal)
        looking2.setTitleColor(.white, for: .normal)
        looking3.setTitleColor(.white, for: .normal)

        sender.setTitleColor(.black, for: .normal)
        looking = true
        
        if sender.tag == 3 {
            UserDefaults.standard.set("looking in <b>friendship</b>", forKey: "looking")
        }else if sender.tag == 4 {
            UserDefaults.standard.set("looking in <b>casual dating</b>", forKey: "looking")
        }else if sender.tag == 5 {
            UserDefaults.standard.set("looking in <b>serious relationship</b>", forKey: "looking")
        }
    }
    
    @IBAction func budgetClick(_ sender: UIButton) {
        budget1.setTitleColor(.white, for: .normal)
        budget2.setTitleColor(.white, for: .normal)
        budget3.setTitleColor(.white, for: .normal)
        budget4.setTitleColor(.white, for: .normal)
        
        sender.setTitleColor(.black, for: .normal)
        budget = true
        
        if sender.tag == 6 {
            UserDefaults.standard.set("budget in <b>tea shop($)</b>", forKey: "looking")
        }else if sender.tag == 7 {
            UserDefaults.standard.set("budget in <b>cafe($$)</b>", forKey: "looking")
        }else if sender.tag == 8 {
            UserDefaults.standard.set("budget in <b>resturant($$$)</b>", forKey: "looking")
        }else if sender.tag == 9 {
            UserDefaults.standard.set("budget in <b>hotel($$$$)</b>", forKey: "looking")
        }
        
        
    }
    @IBAction func nextClick(_ sender: UIButton) {
        if interest && looking && budget {
            
        }
    }
    
}
