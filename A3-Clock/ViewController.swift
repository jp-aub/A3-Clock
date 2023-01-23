//
//  ViewController.swift
//  A3-Clock
//
//  Created by JP on 1/23/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    var timeAndDate = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeAndDate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.second) , userInfo: nil, repeats: true)
    }
    
    @objc func second() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
    }
    
}

