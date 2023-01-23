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
        
        // Set up current time. Must be done before timer to ensure no delay upon start up.
        timeNow()
        
        // Begin timer
        timeAndDate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.timeNow) , userInfo: nil, repeats: true)
    }
    
    @objc func timeNow() {
        let dateFormatting = DateFormatter()
        dateFormatting.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateLabel.text = dateFormatting.string(from: Date())
    }
    
}

