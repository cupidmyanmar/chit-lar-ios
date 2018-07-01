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
import SDWebImage
import Spring

private var numberOfCards: Int = 5

class HomeViewController: UIViewController {
    
    var persons = [Person]()
    
    @IBOutlet var match: SpringImageView!
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var textView: UITextView!
    
//    fileprivate var dataSource: [UIImage] = {
//        var array: [UIImage] = []
//        for index in 0..<numberOfCards {
//            array.append(UIImage(named: "Card_like_\(index + 1)")!)
//        }
//
//        return array
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        match.isHidden = true
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.textView.text = ""
        self.textView.textAlignment = .center
        
        getPersonList()
    }
    
    func getPersonList() {
        self.persons.removeAll()
        self.kolodaView.reloadData()
        SVProgressHUD.show()
        
        let url = "\(APIStrings.baseUrl)\(APIStrings.personUrl)"
        
        APIClient.shared.requestGETURL(url, headers: APIStrings.formURLEncodedHeader, success: {
            (response) -> Void in
            
            let dics = response as? NSDictionary
            //let status = dics!["status"] as! String
//            let status = dics?["status"] as! String
            
            //if status == "completed" {
                if let arr = dics?["data"] as? NSArray {
                    for dic in arr {
                        if let person = Person.getPersonFromDic(dic as! NSDictionary) {
                            self.persons.append(person)
                        }
                    }
                    self.kolodaView.reloadData()
                    
                    let p = self.persons[0]
                    let attributedText = NSMutableAttributedString(string: p.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.white])
                    
                    attributedText.append(NSAttributedString(string: "\n\n\n\(p.age) years old | Level 3", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
                    
                    attributedText.append(NSAttributedString(string: "\n\n\(p.desc)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
                    
                    self.textView.attributedText = attributedText
                    self.textView.textAlignment = .center
                }
            //}
            SVProgressHUD.dismiss()
            
        }) {
            (error) -> Void in
            SVProgressHUD.dismiss()
        }
    }

    func goToDate() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "date") as! DateViewController
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDetailDone))
        
        let navController: UINavigationController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(navController, animated: true, completion: {
            self.match.isHidden = true
        })
    }
    
    @objc func onDetailDone(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
}

extension HomeViewController: KolodaViewDelegate {
    
//    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        let position = kolodaView.currentCardIndex
//        for i in 1...4 {
//            dataSource.append(UIImage(named: "Card_like_\(i)")!)
//        }
//        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
//        kolodaView.reloadData()
//    }
    
//    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        self.goToDate()
//    }
    
}

// MARK: KolodaViewDataSource

extension HomeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return persons.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let p = persons[index]
//
//        let attributedText = NSMutableAttributedString(string: p.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.white])
//
//        attributedText.append(NSAttributedString(string: "\n\n\n\(p.age) years old | Level 3", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
//
//        attributedText.append(NSAttributedString(string: "\n\n\(p.desc)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
//
//        textView.attributedText = attributedText
//        textView.textAlignment = .center
        
        let img = UIImageView()
        img.sd_setImage(with: URL(string: p.photo))
        return img
//        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        switch direction {
        case .right:
            if persons[index].uniq_id == "mary" {
                match.isHidden = false
                match.animation = "slideDown"
                match.animate()
                match.animateNext {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.goToDate()
                    })
                }
            }
        default:
            break
        }
        if index + 1 < persons.count {
            let p = self.persons[index + 1]
            let attributedText = NSMutableAttributedString(string: p.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.white])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(p.age) years old | Level 3", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
            
            attributedText.append(NSAttributedString(string: "\n\n\(p.desc)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]))
            
            self.textView.attributedText = attributedText
            self.textView.textAlignment = .center
        }else {
            self.textView.text = ""
            self.textView.textAlignment = .center
        }
        
    }
}
