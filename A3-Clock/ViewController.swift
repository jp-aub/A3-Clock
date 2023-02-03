//
//  ViewController.swift
//  A3-Clock
//
//  Created by JP on 1/23/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countdownTimer: UIDatePicker!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    
    var timeAndDate = Timer() // Timer for current time and date
    var timeLeft : Int? // Will hold the remaining countdown time left
    var countdownTime = Timer() // Timer for countdown
    var countdownBtnStatus = 0; // 0 = countdown not started
    var musicTimer = Timer() // Timer for music that plays upon countdown reaching 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeRemaining.text = ""
        
        // Set up current time. Must be done before timer to ensure no delay upon start up.
        timeNow()
        
        // Get initial countdown value (default = 1 minute)
        getCountdown()
    
        // Begin timer
        timeAndDate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.timeNow) , userInfo: nil, repeats: true)
    }
    
    // Provides functionality for the live clock.
    @objc func timeNow() {
        let date = Date()
        let dateFormatting = DateFormatter()
        dateFormatting.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateLabel.text = dateFormatting.string(from: date)
        checkTime()
    }
    
    // Establishes the current time (hour) and adjusts the user interface (light or dark mode) based on AM or PM.
    func checkTime() {
        let time = Date()
        let hour = DateFormatter()
        hour.dateFormat = "HH"
        let currentHour = Int(hour.string(from: time))
        
        // Perform the time comparison. 12 represents 12:00 or when the clock changes to PM
        // If the current time is > 0 (current time is after 12:00), change background/color theme to dark mode.
        // If before 12:00, set to light mode.
        if currentHour! >= 12 {
            darkMode()
        } else {
            lightMode()
        }
    }
    
    // Changes user interface to dark mode.
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
    
    // Changes user interface to light mode.
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
    
    func getCountdown() {
        timeLeft = Int(countdownTimer.countDownDuration)
    }
    
    @IBAction func changeCountdown(_ sender: UIDatePicker) {
        timeLeft = Int(countdownTimer.countDownDuration)
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        countdownTime.invalidate()
        // Check if timer is already running.
        // If not, start timer and change button text.
        if countdownBtnStatus == 0 {
            countdownTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        } else if countdownBtnStatus == 1 {
            AudioServicesDisposeSystemSoundID(1151)
            musicTimer.invalidate()
            countdownBtnStatus = 0;
            timeRemaining.text = ""
            timerBtn.setTitle("Start Timer", for: .normal)
            getCountdown()
        }
        
    }
    
    @objc func countdown() {
        // Get seconds remaining on countdown
        let seconds = timeLeft!
        
        // Convert the seconds into a HH:MM:SS format
        let format = DateComponentsFormatter()
        format.allowedUnits = [.hour, .minute, .second]
        format.unitsStyle = .positional
        format.zeroFormattingBehavior = .pad
        let formattedTime = format.string(from: TimeInterval(seconds))!
        
        // Set label text with formatted remaining time
        timeRemaining.text = "Time Remaining: \(formattedTime)"
        
        // If the countdown timer reaches 0, change button text and start the music.
        if timeLeft! <= 0 {
            countdownTime.invalidate()
            timerBtn.setTitle("Stop Music", for: .normal)
            countdownBtnStatus = 1;
            startMusicTimer()
        }
        
        // Decrement timer by one second
        timeLeft! -= 1
    }
    
    func startMusicTimer() {
        // Play sound once before timer starts to avoid initial delay
        AudioServicesPlaySystemSound(1151)
        
        // Begin timer that plays the system sound every two seconds until cancelled
        countdownTime = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(music), userInfo: nil, repeats: true)
    }
    
    // Called by the timer function to play music/system sound
    @objc func music() {
        AudioServicesPlaySystemSound(1151)
    }
}

