//
//  InfoViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 7/1/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    
    var fromQuestion = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromQuestion {
            btnNext.isHidden = false
        }
        else {
            btnNext.isHidden = true
        }

        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        let user = User.getCurrentAuth()
        
        let interest = UserDefaults.standard.string(forKey: "interest")!
        let looking = UserDefaults.standard.string(forKey: "looking")!
        let budget = UserDefaults.standard.string(forKey: "budget")!
        let yourself = UserDefaults.standard.string(forKey: "yourself")!
        let age = UserDefaults.standard.string(forKey: "age")!
        
        imageView.sd_setImage(with: URL(string: user.strPhone))
        
        let attributedText = NSMutableAttributedString(string: user.strFBName, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string: "\n10 points | Level 1 | \(age) year old", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        attributedText.append(NSAttributedString(string: "\n\n\(yourself)\n\n\(interest)\n\n\(looking)\n\n\(budget)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 23), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
//        attributedText.append(NSAttributedString(string: "\n\n\nEarn points from checking in, taking a selfie together and finding the hidden items", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextClick(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier :"guide") as! GuideViewController
        self.present(vc, animated: false, completion: nil)
    }

}
