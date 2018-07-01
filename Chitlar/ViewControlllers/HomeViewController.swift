//
//  HomeViewController.swift
//  Chitlar
//
//  Created by Oak Soe Shein on 6/30/18.
//  Copyright © 2018 Oak Soe Shein. All rights reserved.
//

import UIKit
import SVProgressHUD
import Koloda

private var numberOfCards: Int = 5

class HomeViewController: UIViewController {
    
    var persons = [Person]()
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var textView: UITextView!
    
    fileprivate var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        getPersonList()
        
        let attributedText = NSMutableAttributedString(string: "Mary", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\n26 years old | Level 3 | MICT Park", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nSupporting Argentina in the World Cup", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPersonList() {
        SVProgressHUD.show()
        
        let url = "\(APIStrings.baseUrl)\(APIStrings.personUrl)"
        
        APIClient.shared.requestGETURL(url, headers: nil, success: {
            (response) -> Void in
            
            let dics = response as? NSDictionary
            //let status = dics!["status"] as! String
//            let status = dics?["status"] as! String
            
            //if status == "completed" {
                if let arr = dics?["data"] as? NSArray {
                    for dic in arr {
                        if let person = Person.getPersonFromDic(dic as! NSDictionary) {
                            self.persons.append(person)
                            print(person)
                        }
                    }
                }
            //}
            SVProgressHUD.dismiss()
            
        }) {
            (error) -> Void in
            SVProgressHUD.dismiss()
        }
    }

}

extension HomeViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        for i in 1...4 {
            dataSource.append(UIImage(named: "Card_like_\(i)")!)
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
}

// MARK: KolodaViewDataSource

extension HomeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
