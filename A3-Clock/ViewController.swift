//
//  ViewController.swift
//  A3-Clock
//
//  Created by JP on 1/23/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countdownTimer: UIDatePicker!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    
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
        let date = Date()
        let dateFormatting = DateFormatter()
        dateFormatting.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateLabel.text = dateFormatting.string(from: date)
        checkTime()
    }
    
    func checkTime() {
        let time = Date()
        let hour = DateFormatter()
        hour.dateFormat = "HH"
        let currentHour = hour.string(from: time)
        
        // Perform the time comparison. 12 represents 12:00 or when the clock changes to PM
        let comparison = currentHour.compare("12")
        
        // If the current time is > 0 (current time is after 12:00), change background/color theme
        if comparison.rawValue > 0 {
            darkMode()
        } else {
            lightMode()
        }
    }
    
    func darkMode() {
        view.backgroundColor = UIColor.black
        dateLabel.textColor = UIColor.white
        countdownTimer.setValue(UIColor.black, forKeyPath: "textColor")
        countdownTimer.backgroundColor = UIColor.white
        timerBtn.layer.borderColor = UIColor.white.cgColor
        timerBtn.layer.borderWidth = 1
        timerBtn.titleLabel?.textColor = UIColor.white
        timeRemaining.textColor = UIColor.white
    }
    
    func lightMode() {
        view.backgroundColor = UIColor.white
        dateLabel.textColor = UIColor.black
        countdownTimer.setValue(UIColor.white, forKeyPath: "textColor")
        countdownTimer.backgroundColor = UIColor.black
        timerBtn.layer.borderColor = UIColor.black.cgColor
        timerBtn.layer.borderWidth = 1
        timerBtn.titleLabel?.textColor = UIColor.black
        timeRemaining.textColor = UIColor.black
    }
    
}

