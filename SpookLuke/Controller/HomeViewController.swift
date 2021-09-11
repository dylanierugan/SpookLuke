//
//  HomeViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/10/21.
//

import UIKit
import RealmSwift

class HomeViewController: ATabController, TaskManagementDelegate {
    
// MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var daysCompletionLabel: UILabel!
    @IBOutlet weak var phasesSegment: UISegmentedControl!
    @IBOutlet weak var groundAirSegment: UISegmentedControl!
    @IBOutlet weak var finishDayButton: UIButton!
    @IBOutlet weak var restDayButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
// MARK: - Persistant Data Variables
    
    var inRealm: Bool = UserDefaults.standard.bool(forKey: "inRealm")
    let defaults = UserDefaults.standard
    
// MARK: - Task Variables and Lists
    
    var tasksCompletedCounter = 0
    var totalTasksCompleted = 0
    var previousSegment = 0
    
    var progressOne = Progress(totalUnitCount: 14)
    var progressTwo = Progress(totalUnitCount: 14)
    var progressThree = Progress(totalUnitCount: 7)
    
    var tempTasks: [Task] = [Task(taskName: "Quick Aerial Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                             Task(taskName: "Recovery Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                             Task(taskName: "Shooting Consistency (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                             Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                             Task(taskName: "Ranked Part 1 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                             Task(taskName: "Speed Training Part 1 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                             Task(taskName: "Ranked Part 2 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                             Task(taskName: "Speed Training Part 2 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                             Task(taskName: "Stretch Training (10 min)", time: 10, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]

    // phase one tasks
    var groundTasksPhaseOne: [Task] = [Task(taskName: "Dribble Challenge #2 (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 3),
                            Task(taskName: "Hot Potato (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Aim Training (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Two-Touch (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked (30 min)", time: 30, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Stretch Training (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]
    var airTasksPhaseOne: [Task] = [Task(taskName: "Leth's Rings (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 3),
                            Task(taskName: "Recovery Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Aim Training (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Two-Touch (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked (30 min)", time: 30, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Stretch Training (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]
    
    // phase two tasks
    var groundTasksPhaseTwo: [Task] = [Task(taskName: "Dribble Challenge #2 (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 3),
                            Task(taskName: "Hot Potato (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Aim Training (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Two-Touch (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked (35 min)", time: 35, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Stretch Training (15 min)", time: 15, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]
    var airTasksPhaseTwo: [Task] = [Task(taskName: "Leth's Rings (20 min)", time: 20, completed: false, dataTrackingNeeded: true, numberOfEntries: 3),
                            Task(taskName: "Recovery Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Aim Training (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Two-Touch (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked (35 min)", time: 35, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Stretch Training (15 min)", time: 15, completed: false, dataTrackingNeeded: true,numberOfEntries: 0)]
    
    // phase three tasks
    var groundTasksPhaseThree: [Task] = [Task(taskName: "Quick Aerial Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Recovery Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Shooting Consistency (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked Part 1 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Speed Training Part 1 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked Part 2 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Speed Training Part 2 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Stretch Training (10 min)", time: 10, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]
    var airTasksPhaseThree: [Task] = [Task(taskName: "Quick Aerial Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Recovery Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Shooting Consistency (5 min)", time: 5, completed: false, dataTrackingNeeded: true, numberOfEntries: 1),
                            Task(taskName: "Speed Training (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked Part 1 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Speed Training Part 1 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Ranked Part 2 (40 min)", time: 40, completed: false, dataTrackingNeeded: true, numberOfEntries: 2),
                            Task(taskName: "Speed Training Part 2 (5 min)", time: 5, completed: false, dataTrackingNeeded: false, numberOfEntries: 0),
                            Task(taskName: "Stretch Training (10 min)", time: 10, completed: false, dataTrackingNeeded: true, numberOfEntries: 0)]
    
// MARK: - Day Changed Variable

    var calendar = Calendar.current
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(true, forKey: "userRegistered")
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        let client = realm.objects(ClientData.self)
        nameLabel.text = client[0].name
        
        // check if task data in realm, if not add task data to realm
        if inRealm == false {
            addArrayToRealm(currentTasks: tempTasks)
            updateTaskListRealm(list: groundTasksPhaseOne)
            defaults.set(true, forKey: "inRealm")
        }
        
        // set progress bars based on days completed per phase
        progressOne.completedUnitCount += Int64(client[0].phaseOneDaysCompleted)
        progressTwo.completedUnitCount += Int64(client[0].phaseTwoDaysCompleted)
        progressThree.completedUnitCount += Int64(client[0].phaseThreeDaysCompleted)
        
       // set phase segment and day segment
        if client[0].currentPhase == 0 && client[0].currentDay == "Ground Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 0, groundAirSegmentNum: 0, phaseDaysCompleted: client[0].phaseOneDaysCompleted)
            setProgressView(phaseNumber: 1)
        } else if client[0].currentPhase == 1 && client[0].currentDay == "Ground Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 1, groundAirSegmentNum: 0, phaseDaysCompleted: client[0].phaseTwoDaysCompleted)
            setProgressView(phaseNumber: 2)
        } else if client[0].currentPhase == 2 && client[0].currentDay == "Ground Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 2, groundAirSegmentNum: 0, phaseDaysCompleted: client[0].phaseThreeDaysCompleted)
            setProgressView(phaseNumber: 3)
        } else if client[0].currentPhase == 0 && client[0].currentDay == "Air Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 0, groundAirSegmentNum: 1, phaseDaysCompleted: client[0].phaseOneDaysCompleted)
            setProgressView(phaseNumber: 1)
        } else if client[0].currentPhase == 1 && client[0].currentDay == "Air Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 1, groundAirSegmentNum: 1, phaseDaysCompleted: client[0].phaseTwoDaysCompleted)
            setProgressView(phaseNumber: 2)
        } else if client[0].currentPhase == 2 && client[0].currentDay == "Air Day" {
            setSegmentsAndUIElements(phaseSegmentNum: 2, groundAirSegmentNum: 1, phaseDaysCompleted: client[0].phaseThreeDaysCompleted)
            setProgressView(phaseNumber: 3)
        }
        
        // if on phase 3 disable day segment
        previousSegment = phasesSegment.selectedSegmentIndex
        if phasesSegment.selectedSegmentIndex == 2 {
            groundAirSegment.isEnabled = false
        } else {
            groundAirSegment.isEnabled = true
        }
        
        // other UI objects
        tasksCompletedCounter = defaults.integer(forKey: "tasksCompleted")
        completionLabel.text = "\(tasksCompletedCounter) out of \(checkPhaseReturnCount())"
        totalTasksCompleted = defaults.integer(forKey: "totalTasksCompleted")
        finishDayButton.layer.cornerRadius = 10
        restDayButton.layer.cornerRadius = 10
        setColors()
        taskTableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setName), name: .name, object: nil)
    }

    @objc func setName() {
        let client = realm.objects(ClientData.self)
        nameLabel.text = client[0].name
    }
    
    func setSegmentsAndUIElements (phaseSegmentNum: Int, groundAirSegmentNum: Int, phaseDaysCompleted: Int) {
        // sets phase and ground segment based on previous placement
        phasesSegment.selectedSegmentIndex = phaseSegmentNum
        groundAirSegment.selectedSegmentIndex = groundAirSegmentNum
        daysCompletionLabel.text = String(phaseDaysCompleted)
        progressView.progress = Float(phaseDaysCompleted / 7)
    }
 
// MARK: - Segment Control
    
    // phase control
    @IBAction func phaseSegmentChanged(_ sender: UISegmentedControl) {
        // change tasks based on what phase the user chooses
        
        let client = realm.objects(ClientData.self)
        if sender.selectedSegmentIndex == 0 && groundAirSegment.selectedSegmentIndex == 0 {
            // Phase 1 - Ground Day
            changePhase(phase: 0, client: client, selectedSegmentNumberPhase: 0, list: groundTasksPhaseOne, daysCompletedText: String(client[0].phaseOneDaysCompleted))
        } else if sender.selectedSegmentIndex == 0 && groundAirSegment.selectedSegmentIndex == 1 {
            // Phase 1 - Air Day
            changePhase(phase: 0, client: client, selectedSegmentNumberPhase: 0, list: airTasksPhaseOne, daysCompletedText: String(client[0].phaseOneDaysCompleted))
        } else if sender.selectedSegmentIndex == 1 && groundAirSegment.selectedSegmentIndex == 0 {
            // Phase 2 - Ground Day
            changePhase(phase: 1, client: client, selectedSegmentNumberPhase: 1, list: groundTasksPhaseTwo, daysCompletedText:  String(client[0].phaseTwoDaysCompleted))
        } else if sender.selectedSegmentIndex == 1 && groundAirSegment.selectedSegmentIndex == 1 {
            // Phase 2 - Air Day
            changePhase(phase: 1, client: client, selectedSegmentNumberPhase: 1, list: airTasksPhaseTwo, daysCompletedText: String(client[0].phaseTwoDaysCompleted))
        } else if sender.selectedSegmentIndex == 2 && groundAirSegment.selectedSegmentIndex == 0 {
            // Phase 3 - Ground Day
            changePhase(phase: 2, client: client, selectedSegmentNumberPhase: 2, list: groundTasksPhaseThree, daysCompletedText: String(client[0].phaseThreeDaysCompleted) )
        } else if sender.selectedSegmentIndex == 2 && groundAirSegment.selectedSegmentIndex == 1 {
            // Phase 3 - Air Day
            changePhase(phase: 2, client: client, selectedSegmentNumberPhase: 2, list: airTasksPhaseThree, daysCompletedText: String(client[0].phaseThreeDaysCompleted))
        }
    }
    
    // day segment control
    @IBAction func daySegmentChanged(_ sender: UISegmentedControl) {
        // change tasks based on what day type the user chooses
        let client = realm.objects(ClientData.self)
        if sender.selectedSegmentIndex == 0 && phasesSegment.selectedSegmentIndex == 0 {
            // Ground Day - Phase 1
            changeDay(dayString: "Ground Day", client: client, selectedSegmentNumberDay: 0, list: groundTasksPhaseOne)
        } else if sender.selectedSegmentIndex == 0 && phasesSegment.selectedSegmentIndex == 1 {
            // Ground Day - Phase 2
            changeDay(dayString: "Ground Day", client: client, selectedSegmentNumberDay: 0, list: groundTasksPhaseTwo)
        } else if sender.selectedSegmentIndex == 0 && phasesSegment.selectedSegmentIndex == 2 {
            // Ground Day - Phase 3
            changeDay(dayString: "Ground Day", client: client, selectedSegmentNumberDay: 0, list: groundTasksPhaseThree)
        } else if sender.selectedSegmentIndex == 1 && phasesSegment.selectedSegmentIndex == 0 {
            // Air Day - Phase 1
            changeDay(dayString: "Air Day", client: client, selectedSegmentNumberDay: 1, list: airTasksPhaseOne)
        } else if sender.selectedSegmentIndex == 1 && phasesSegment.selectedSegmentIndex == 1 {
            // Air Day - Phase 2
            changeDay(dayString: "Air Day", client: client, selectedSegmentNumberDay: 1, list: airTasksPhaseTwo)
        } else if sender.selectedSegmentIndex == 1 && phasesSegment.selectedSegmentIndex == 2 {
            // Air Day - Phase 3
            changeDay(dayString: "Air Day", client: client, selectedSegmentNumberDay: 1, list: airTasksPhaseThree)
        }
    }
    
    func changePhase(phase: Int, client: Results<ClientData>, selectedSegmentNumberPhase: Int, list: [Task], daysCompletedText: String){
        // prompt pop up to change phase
        let resetAlert = UIAlertController(title: "Are you sure you want to switch phases?", message: "Progress for current day will be lost.", preferredStyle: UIAlertController.Style.alert)
        // cancel change
        resetAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { [self] (action: UIAlertAction!) in
            phasesSegment.selectedSegmentIndex = previousSegment
        }))
        resetAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (action: UIAlertAction!) in
            // update realm objects
            do {
                try realm.write {
                    client[0].currentPhase = phase
                }
            } catch {
                print("Error changing phases, \(error)")
            }
            // disable day segment if on phase 3
            if phase == 2 {
                groundAirSegment.isEnabled = false
            } else {
                groundAirSegment.isEnabled = true
            }
            updateTaskListRealm(list: list)
            previousSegment = selectedSegmentNumberPhase // for going back if user cancels
            // reset some values
            tasksCompletedCounter = 0
            defaults.set(tasksCompletedCounter, forKey: "tasksCompleted")
            completionLabel.text = "\(tasksCompletedCounter) out of \(checkPhaseReturnCount())"
            daysCompletionLabel.text = daysCompletedText
            setProgressView(phaseNumber: phase + 1)
        }))
        present(resetAlert, animated: true, completion: nil)
    }
    
    func changeDay(dayString: String, client: Results<ClientData>, selectedSegmentNumberDay: Int, list: [Task]) {
        // prompt pop up to change day
        let resetAlert = UIAlertController(title: "Are you sure you want to switch days?", message: "Progress for current day will be lost.", preferredStyle: UIAlertController.Style.alert)
        // cancel change
        resetAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { [self] (action: UIAlertAction!) in
            if selectedSegmentNumberDay == 0 {
                groundAirSegment.selectedSegmentIndex = 1
            } else if selectedSegmentNumberDay == 1 {
                groundAirSegment.selectedSegmentIndex = 0
            }
        }))
        resetAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (action: UIAlertAction!) in
            // update realm objects
            do {
                try realm.write {
                    client[0].currentDay = dayString
                }
            } catch {
                print("Error changing phases, \(error)")
            }
            updateTaskListRealm(list: list)
            tasksCompletedCounter = 0
            defaults.set(tasksCompletedCounter, forKey: "tasksCompleted")
            completionLabel.text = "\(tasksCompletedCounter) out of \(checkPhaseReturnCount())"
        }))
        present(resetAlert, animated: true, completion: nil)
    }
    
    func updateTaskListRealm(list: [Task]){
        // update task object in realm to new current task based on phase and day chosen
        let tasks = realm.objects(Task.self)
        try! realm.write {
            for i in 0..<list.count {
                tasks[i].taskName = list[i].taskName
                tasks[i].time = list[i].time
                tasks[i].comepleted = list[i].comepleted
                tasks[i].dataTrackingNeeded = list[i].dataTrackingNeeded
                tasks[i].numberOfEntries = list[i].numberOfEntries
            }
        }
        taskTableView.reloadData()
    }
    
    func setColors(cell: TaskCell? = nil) {
        // set UI colors based on phase numner
        let client = realm.objects(ClientData.self)
        if client[0].currentPhase == 0 {
            cell?.taskBubble.backgroundColor = UIColor(named: "phase1")
            daysCompletionLabel.textColor = UIColor(named: "phase1")
            completionLabel.textColor = UIColor(named: "phase1")
        } else if client[0].currentPhase == 1 {
            cell?.taskBubble.backgroundColor = UIColor(named: "phase2")
            daysCompletionLabel.textColor = UIColor(named: "phase2")
            completionLabel.textColor = UIColor(named: "phase2")
        } else if client[0].currentPhase == 2 {
            cell?.taskBubble.backgroundColor = UIColor(named: "phase3")
            daysCompletionLabel.textColor = UIColor(named: "phase3")
            completionLabel.textColor = UIColor(named: "phase3")
        }
    }
    
// MARK: - Rest Day Button
    
    @IBAction func restDayButtonPressed(_ sender: UIButton) {
        // move forward one day if user uses rest
        let alert = UIAlertController(title: "Are you sure you want to progress with a rest day?", message: "This action cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
            // do nothing
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (action: UIAlertAction!) in
            // update realm objects
            let client = realm.objects(ClientData.self)
            do {
                try realm.write {
                    if client[0].currentPhase == 0 {
                        client[0].phaseOneDaysCompleted += 1
                        daysCompletionLabel.text = String(client[0].phaseOneDaysCompleted)
                        updateProgressView(phaseNumber: 1)
                        checkIfPhaseCompleted(phaseNumber: 1)
                    } else if client[0].currentPhase == 1 {
                        client[0].phaseTwoDaysCompleted += 1
                        daysCompletionLabel.text = String(client[0].phaseTwoDaysCompleted)
                        updateProgressView(phaseNumber: 2)
                        checkIfPhaseCompleted(phaseNumber: 2)
                    } else if client[0].currentPhase == 2 {
                        client[0].phaseThreeDaysCompleted += 1
                        daysCompletionLabel.text = String(client[0].phaseThreeDaysCompleted)
                        updateProgressView(phaseNumber: 3)
                        checkIfPhaseCompleted(phaseNumber: 3)
                    }
                }
            } catch {
                print("Error updating client in realm, \(error)")
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
// MARK: - Finish Day
    
    @IBAction func refreshTapped(_ sender: UIButton) {
        // move forward one day if user completes all tasks for the day
        let client = realm.objects(ClientData.self)
        if tasksCompletedCounter != checkPhaseReturnCount() {
            let alert = UIAlertController(title: "All tasks not completed.", message: "All tasks must be completed to move on to the next day.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                // cancel - do nothing
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Are you sure you want finish today's tasks?", message: "A day will be logged and tasks for the next day will appear.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                // do nothing
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (action: UIAlertAction!) in
                // update realm objects
                tasksCompletedCounter = 0
                defaults.set(0, forKey: "tasksCompleted")
                completionLabel.text = "\(tasksCompletedCounter) out of \(checkPhaseReturnCount())"
                
                do {
                    try realm.write {
                        if client[0].currentPhase == 0 && client[0].currentDay == "Ground Day" {
                            client[0].phaseOneDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 1
                            daysCompletionLabel.text = String(client[0].phaseOneDaysCompleted)
                            progressView.progress = Float(client[0].phaseOneDaysCompleted / 14)
                            updateProgressView(phaseNumber: 1)
                            checkIfPhaseCompleted(phaseNumber: 1)
                        } else if client[0].currentPhase == 1 && client[0].currentDay == "Ground Day" {
                            client[0].phaseTwoDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 1
                            daysCompletionLabel.text = String(client[0].phaseTwoDaysCompleted)
                            progressView.progress = Float(client[0].phaseTwoDaysCompleted / 14)
                            updateProgressView(phaseNumber: 2)
                            checkIfPhaseCompleted(phaseNumber: 2)
                        } else if client[0].currentPhase == 2 && client[0].currentDay == "Ground Day" {
                            client[0].phaseThreeDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 1
                            daysCompletionLabel.text = String(client[0].phaseThreeDaysCompleted)
                            progressView.progress = Float(client[0].phaseThreeDaysCompleted / 7)
                            updateProgressView(phaseNumber: 3)
                            checkIfPhaseCompleted(phaseNumber: 3)
                        } else if client[0].currentPhase == 0 && client[0].currentDay == "Air Day" {
                            client[0].phaseOneDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 0
                            daysCompletionLabel.text = String(client[0].phaseOneDaysCompleted)
                            progressView.progress = Float(client[0].phaseOneDaysCompleted / 14)
                            updateProgressView(phaseNumber: 1)
                            checkIfPhaseCompleted(phaseNumber: 1)
                        } else if client[0].currentPhase == 1 && client[0].currentDay == "Air Day" {
                            client[0].phaseTwoDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 0
                            daysCompletionLabel.text = String(client[0].phaseTwoDaysCompleted)
                            progressView.progress = Float(client[0].phaseTwoDaysCompleted / 14)
                            updateProgressView(phaseNumber: 2)
                            checkIfPhaseCompleted(phaseNumber: 2)
                        } else if client[0].currentPhase == 2 && client[0].currentDay == "Air Day" {
                            client[0].phaseThreeDaysCompleted += 1
                            groundAirSegment.selectedSegmentIndex = 0
                            daysCompletionLabel.text = String(client[0].phaseThreeDaysCompleted)
                            progressView.progress = Float(client[0].phaseThreeDaysCompleted / 7)
                            updateProgressView(phaseNumber: 3)
                            checkIfPhaseCompleted(phaseNumber: 3)
                        }
                    }
                } catch {
                    print("Error updating client in realm, \(error)")
                }
                if client[0].currentPhase == 0 && client[0].currentDay == "Ground Day" {
                    updateTaskListRealm(list: airTasksPhaseOne)
                    updateCurrentDayRealm(dayString: "Air Day")
                } else if client[0].currentPhase == 1 && client[0].currentDay == "Ground Day" {
                    updateTaskListRealm(list: airTasksPhaseTwo)
                    updateCurrentDayRealm(dayString: "Air Day")
                } else if client[0].currentPhase == 2 && client[0].currentDay == "Ground Day" {
                    updateTaskListRealm(list: airTasksPhaseThree)
                    updateCurrentDayRealm(dayString: "Air Day")
                } else if client[0].currentPhase == 0 && client[0].currentDay == "Air Day" {
                    updateTaskListRealm(list: groundTasksPhaseOne)
                    updateCurrentDayRealm(dayString: "Ground Day")
                } else if client[0].currentPhase == 1 && client[0].currentDay == "Air Day" {
                    updateTaskListRealm(list: groundTasksPhaseTwo)
                    updateCurrentDayRealm(dayString: "Ground Day")
                } else if client[0].currentPhase == 2 && client[0].currentDay == "Air Day" {
                    updateTaskListRealm(list: groundTasksPhaseThree)
                    updateCurrentDayRealm(dayString: "Ground Day")
                }
                taskTableView.reloadData()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateCurrentDayRealm(dayString: String) {
        let client = realm.objects(ClientData.self)
        do {
            try realm.write {
                client[0].currentDay = dayString
            }
        } catch {
            print("Error changing phases, \(error)")
        }
    }
    
    func checkIfPhaseCompleted(phaseNumber: Int) {
        let client = realm.objects(ClientData.self)
        if client[0].phaseOneDaysCompleted == 14 {
            phaseCompletedAlert(phaseNumber: 1)
        } else if client[0].phaseTwoDaysCompleted == 14 {
            phaseCompletedAlert(phaseNumber: 2)
        } else if client[0].phaseThreeDaysCompleted == 7 {
            phaseCompletedAlert(phaseNumber: 3)
        }
    }
    
    func phaseCompletedAlert(phaseNumber: Int) {
        let alert = UIAlertController(title: "Phase \(phaseNumber) completed!", message: "You can still continue to complete tasks in phase \(phaseNumber).", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            // cancel - do nothing
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func updateProgressView(phaseNumber: Int) {
        if phaseNumber == 1 {
            progressOne.completedUnitCount += 1
            let progressFloat = Float(progressOne.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        } else if phaseNumber == 2 {
            progressTwo.completedUnitCount += 1
            let progressFloat = Float(progressTwo.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        } else if phaseNumber == 3 {
            progressThree.completedUnitCount += 1
            let progressFloat = Float(progressThree.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    func setProgressView(phaseNumber: Int) {
        if phaseNumber == 1 {
            let progressFloat = Float(progressOne.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        } else if phaseNumber == 2 {
            let progressFloat = Float(progressTwo.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        } else if phaseNumber == 3 {
            let progressFloat = Float(progressThree.fractionCompleted)
            progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    func displayNewCompletionAlert(phaseNumber: Int, client: Results<ClientData>) {
        let alert = UIAlertController(title: "Phase 1 completed!", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        present(alert, animated: true, completion: nil)
        do {
            try realm.write {
                client[0].phaseOneDaysCompleted += 1
                daysCompletionLabel.text = String(client[0].phaseOneDaysCompleted)
            }
        } catch {
            print("Error updating client in realm, \(error)")
        }
    }
    
// MARK: - Add Array to Realm
    
    func addArrayToRealm(currentTasks: [Task]) {
        let realm = try! Realm()
        let tempTasks = currentTasks
            do {
                try realm.write{
                    realm.add(tempTasks)
                }
            } catch {
                print("Error saving name: \(error)")
            }
    }
    
// MARK: - Task VC Delegate
    
    func TaskManagementWillDismissed(selectedTask: Task) {
        // runs when a task is marked as comeplted
        let task = realm.objects(Task.self).filter("taskName == %@", selectedTask.taskName).first!
        do {
            try realm.write {
                task.comepleted = true
            }
        } catch {
            print("Error marking task as completed: \(error)")
        }
        // update ui
        totalTasksCompleted += 1
        defaults.set(totalTasksCompleted, forKey: "totalTasksCompleted")
        tasksCompletedCounter += 1
        defaults.set(tasksCompletedCounter, forKey: "tasksCompleted")
        completionLabel.text = "\(tasksCompletedCounter) out of \(checkPhaseReturnCount())"
        if task.dataTrackingNeeded == true {
            // if data tracking switch tabs
            tabDelegate?.switchTab(to: .second)
        }
        taskTableView.reloadData()
    }
}

// MARK: - Table View Delegates

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return number of rows needed based on size of array
        checkPhaseReturnCount()
    }
    
    func checkPhaseReturnCount() -> Int {
        let client = realm.objects(ClientData.self)
        if client[0].currentPhase == 0 {
            return 7
        } else if client[0].currentPhase == 1 {
            return 7
        } else if client[0].currentPhase == 2  {
            return 9
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell for each task and return cell
        let task = realm.objects(Task.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! TaskCell
        cell.setTask(task: task[indexPath.row])
        // check if task is completed, if so make it gray
        if task[indexPath.row].comepleted == true {
            cell.taskBubble.backgroundColor = UIColor.gray
        } else {
            setColors(cell: cell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // segue to task details when cell selected
        performSegue(withIdentifier: "homeToTaskDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue to task page
        let taskVC = segue.destination as! TaskManagementViewContoller
        taskVC.taskDelegate = self
        if let indexPath = taskTableView.indexPathForSelectedRow {
            let task = realm.objects(Task.self)
            taskVC.selectedTask = task[indexPath.row]
        }
    }
}

// MARK: - Notifcation Extension

extension Notification.Name {
     static let name = Notification.Name("name")
        static let didReceiveData = Notification.Name("didReceiveData")
}

