//
//  TaskManagementViewContoller.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/17/21.
//

import UIKit
import RealmSwift
import AVFoundation
import UserNotifications

protocol TaskManagementDelegate {
    func TaskManagementWillDismissed(selectedTask: Task)
}

class TaskManagementViewContoller: ATabController {
    
// MARK: - Incoming Task Variables
    
    weak var taskDelegate : HomeViewController?
    var selectedTask: Task?
    var minutes: Int = 0
    
// MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
// MARK: - Task Variables
    
    var seconds = 0
    var secondsString = ""
    var timer = Timer()
    var timerIsRunning = false
    var resumeTapped = false
    var audioPlayer: AVAudioPlayer?
    
// MARK: - Time Variables
    
    var playOnScreenAlert = true
    var didEnterBackgroundTime = Date()
    var didEnterForegroundTime = Date()
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // button roundness
        completeButton.layer.cornerRadius = 15
        startButton.layer.cornerRadius = 15
        resetButton.layer.cornerRadius = 15
        pauseButton.layer.cornerRadius = 15
        
        // timer UI setup
        pauseButton.isEnabled = false
        pauseButton.backgroundColor = UIColor.gray
        minutes = selectedTask!.time
        secondsString = String(format: "%02d", seconds);
        timerLabel.text = "\(minutes):\(secondsString)"
        
        // splice and set task name
        let taskName = selectedTask!.taskName
        let index = taskName.firstIndex(of: "(")!
        taskNameLabel.text = String(taskName[..<index])
        
        // check if task completed
        if selectedTask?.comepleted == true {
            completeButton.setTitle("Task Completed", for: .normal)
            completeButton.isEnabled = false
            completeButton.backgroundColor = UIColor.gray
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func applicationDidEnterBackground(_ application: UIApplication) {
        didEnterBackgroundTime = Date()
        playOnScreenAlert = false
    }
    
    @objc func applicationDidBecomeActive(_ application: UIApplication) {
        // when user comes back to app
        didEnterForegroundTime = Date()
        if timerIsRunning == true {
            playOnScreenAlert = true
            var secondsPassed = didEnterForegroundTime.seconds(from: didEnterBackgroundTime)
            let minutesPassed = secondsPassed / 60
            secondsPassed = secondsPassed % 60
            seconds = seconds - secondsPassed
            minutes = minutes - minutesPassed
            if minutes < 0 {
                minutes = 0
            }
            if seconds < 0 {
                seconds = 0
            }
            updateLabel()
        }
    }
 
// MARK: - Notification Function
    
    func createNotification(){
        newNotification.content = UNMutableNotificationContent()
        newNotification.content.title = "Timer's Up!"
        newNotification.content.body = "Come mark task as complete."
        newNotification.content.sound = UNNotificationSound.default
        // if minutes is less than 0 use seconds to set when notification goes off
        if minutes > 0 {
            newNotification.trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((minutes * 60)), repeats: false)
        } else {
            newNotification.trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((seconds)), repeats: false)
        }
        newNotification.uuid = UUID().uuidString
        let request = UNNotificationRequest.init(identifier: newNotification.uuid, content: newNotification.content, trigger: newNotification.trigger)
        newNotification.center.add(request) { error in
            print("Error executing request: \(String(describing: error))")
        }
    }
    
// MARK: - Timer Handling Functions and Actions
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        // start timer
        if timerIsRunning == false {
            runTimer()
            self.startButton.isEnabled = false
            startButton.backgroundColor = UIColor.gray
            timerIsRunning = true
        }
        // start notification timer
        playOnScreenAlert = true
        createNotification()
        perform(#selector(timerFinished), with: nil, afterDelay: TimeInterval(minutes * 60))
    }
    
    @objc func timerFinished() {
        minutes = 0
        seconds = 0
        updateLabel()
        if playOnScreenAlert == true {
                AudioServicesPlaySystemSound(1304)
        }
    }
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        // pause timer
        if resumeTapped == false {
            // pause and make resume button
            timer.invalidate()
            resetButton.isEnabled = false
            resetButton.backgroundColor = UIColor.gray
            resumeTapped = true
            pauseButton.setTitle("Resume",for: .normal)
            // remove notification timer
            newNotification.center.removePendingNotificationRequests(withIdentifiers: [newNotification.uuid])
        } else {
            // resume and make pause button
            resetButton.isEnabled = true
            resetButton.backgroundColor = UIColor.link
            runTimer()
            resumeTapped = false
            self.pauseButton.setTitle("Pause",for: .normal)
            createNotification()
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        // reset timer
        timer.invalidate()
        minutes = selectedTask!.time
        seconds = 0
        secondsString = String(format: "%02d", seconds);
        timerLabel.text = "\(minutes):\(secondsString)"
        timerIsRunning = false
        pauseButton.isEnabled = false
        pauseButton.backgroundColor = UIColor.gray
        self.pauseButton.setTitle("Pause",for: .normal)
        startButton.isEnabled = true
        startButton.backgroundColor = UIColor.link
        newNotification.center.removePendingNotificationRequests(withIdentifiers: [newNotification.uuid])
    }
    
    func runTimer() {
        // run timer with 1 second interval
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:(#selector(TaskManagementViewContoller.updateTimer)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        pauseButton.isEnabled = true
        pauseButton.backgroundColor = UIColor.link
    }
    
    @objc func updateTimer() {
        // decrement timer
        if seconds < 1 && minutes == 0{
            timer.invalidate()
            pauseButton.isEnabled = false
            pauseButton.backgroundColor = UIColor.gray
        } else if seconds > 0 {
            seconds -= 1
        } else if minutes > 0 && seconds == 0{
            minutes -= 1
            seconds = 59
        }
        updateLabel()
    }
    
    func updateLabel() {
        // update timer label
        secondsString = String(format: "%02d", seconds);
        timerLabel.text = "\(minutes):\(secondsString)"
    }
    
// MARK: - Finish Task and Dismiss
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        // send task to homeViewController to be marked as complete and update table
        taskDelegate?.TaskManagementWillDismissed(selectedTask: selectedTask!)
        if selectedTask!.dataTrackingNeeded == true {
            // show pop up if task requires data tracking
            let alert = UIAlertController(title: "Save Data For This Task", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Track Here", style: .default, handler: { [self] (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: {})
            }))
            present(alert, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: {})
        }
    }
}


extension Date {
    
    // Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    // Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
            return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
   
}
