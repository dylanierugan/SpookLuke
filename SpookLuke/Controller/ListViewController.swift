//
//  ListViewController.swift
//  SpookLuke
//
//  Created by Dylan Ierugan on 7/25/21.
//

import UIKit
import RealmSwift
import Charts
import TinyConstraints

class ListViewController: UIViewController, ChartViewDelegate {
    
    
// MARK: - Outlets
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var entryOneLabel: UILabel!
    @IBOutlet weak var entryTwoLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var entriesLabel: UILabel!
    
// MARK: - Variables
    
    let realm = RealmService.shared.realm
    var dataObject : Object?
    var DC2OverhaulDataList: Results<DC2OverhaulData>?
    var LethsRingsDataList: Results<LethsRingsData>?
    var AimTrainingDataList: Results<AimTrainingData>?
    var RankedDataList: Results<RankedData>?
    
// MARK: - Incoming Variables from previous VC
    
    var dataDelegate : DataViewController?
    var listTitle: String?
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem!.title = listTitle
        dataTableView.delegate = self
        dataTableView.dataSource = self
        // set which list to be loaded based on data object passed to vc
        switch dataObject {
        case is DC2OverhaulData:
            var dataListCopy: Results<DC2OverhaulData>? // to avoid exclusive access error
            RealmService.shared.loadData(list: &dataListCopy, object: DC2OverhaulData.self, table: dataTableView)
            DC2OverhaulDataList = dataListCopy
            dataTableView.rowHeight = 80
        case is LethsRingsData:
            var dataListCopy: Results<LethsRingsData>? // to avoid exclusive access error
            RealmService.shared.loadData(list: &dataListCopy, object: LethsRingsData.self, table: dataTableView)
            LethsRingsDataList = dataListCopy
            dataTableView.rowHeight = 80
        case is AimTrainingData:
            var dataListCopy: Results<AimTrainingData>? // to avoid exclusive access error
            RealmService.shared.loadData(list: &dataListCopy, object: AimTrainingData.self, table: dataTableView)
            AimTrainingDataList = dataListCopy
            dataTableView.rowHeight = 60
        case is RankedData:
            var dataListCopy: Results<RankedData>? // to avoid exclusive access error
            RealmService.shared.loadData(list: &dataListCopy, object: RankedData.self, table: dataTableView)
            RankedDataList = dataListCopy
            dataTableView.rowHeight = 80
        default:
            print("Error loading list")
        }
        dataTableView.reloadData()
    }

// MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // set which alert gets showed based on data object passed to vc
        switch dataObject {
        case is DC2OverhaulData:
            let newObject = DC2OverhaulData()
            AlertService.addAlert(in: self, table: dataTableView, object: newObject)
        case is LethsRingsData:
            let newObject = LethsRingsData()
            AlertService.addAlert(in: self, table: dataTableView, object: newObject)
        case is AimTrainingData:
            let newObject = AimTrainingData()
            AlertService.addAlert(in: self, table: dataTableView, object: newObject)
        case is RankedData:
            let newObject = RankedData()
            AlertService.addAlert(in: self, table: dataTableView, object: newObject)
        default:
            print("Error adding alert")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    

// MARK: - Graph Functions
    
    func setGraphFeatures() {
        // axis design
        graphView.rightAxis.enabled = false
        graphView.drawBordersEnabled = true
        graphView.borderLineWidth = 1
        graphView.borderColor = UIColor(named: "textColor")!
        // y axis
        let yAxis = graphView.leftAxis
        yAxis.axisLineWidth = 1
        yAxis.axisLineColor = UIColor(named: "textColor")!
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.maxWidth = 30
        yAxis.drawGridLinesEnabled = false
        // x axis
        let xAxis = graphView.xAxis
        xAxis.axisLineWidth = 1
        xAxis.axisLineColor = UIColor(named: "textColor")!
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        // legend
        let legend = graphView.legend
        legend.font = .boldSystemFont(ofSize: 12)
        legend.form = .circle
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .top
        legend.drawInside = false
        // animation
        graphView.animate(xAxisDuration: 0.1)
    }
    
    func createGraph<T: DataProtocol>(list: Results<T>?, object: T, color1: NSUIColor, color2: NSUIColor, color3: NSUIColor, CFArray1: CFArray, CFArray2: CFArray, CFArray3: CFArray) {
        let data = LineChartData()
        // check if data has first entry
        if object.numberOfEntries >= 2 {
            var lineChartEntry1 = [ChartDataEntry]()
            // create chart data entry array
            if list?.count != 0 {
                for i in 0..<list!.count {
                    let value1 = ChartDataEntry(x: Double(i), y: Double((list![i].entryOneInt)))
                    lineChartEntry1.append(value1)
                }
            }
            // set line attributes
            let line1 = LineChartDataSet(entries: lineChartEntry1, label: object.entryOneString)
            line1.colors = [color1]
            line1.setCircleColor(color1)
            line1.circleHoleColor = color1
            line1.circleRadius = 4
            line1.mode = .cubicBezier
            line1.lineWidth = 3
            let gradientColors = CFArray1 as CFArray // Colors of the gradient
            let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
            line1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
            line1.drawFilledEnabled = true // Draw the Gradient
            data.addDataSet(line1)
        }
        if object.numberOfEntries == 3 {
            var lineChartEntry3 = [ChartDataEntry]()
            // create chart data entry array
            if list?.count != 0 {
                for i in 0..<list!.count {
                    let value3 = ChartDataEntry(x: Double(i), y: Double((list![i].entryThreeInt)))
                    lineChartEntry3.append(value3)
                }
            }
            // set line attributes
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: object.entryThreeString)
            line3.colors = [color3]
            line3.setCircleColor(color3)
            line3.circleHoleColor = color3
            line3.circleRadius = 4
            line3.mode = .cubicBezier
            line3.lineWidth = 3
            let gradientColors = CFArray3 as CFArray // Colors of the gradient
            let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
            line3.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
            line3.drawFilledEnabled = true // Draw the Gradient
            data.addDataSet(line3)
        }
        // all entries have this
        var lineChartEntry2 = [ChartDataEntry]()
        if list?.count != 0 {
            for i in 0..<list!.count {
                let value2 = ChartDataEntry(x: Double(i), y: Double((list![i].entryTwoInt)))
                lineChartEntry2.append(value2)
            }
        }
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: object.entryTwoString)
        line2.colors = [color2]
        line2.setCircleColor(color2)
        line2.circleHoleColor = color2
        line2.circleRadius = 4
        line2.mode = .cubicBezier
        line2.lineWidth = 3
        let gradientColors = CFArray2 as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        line2.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        line2.drawFilledEnabled = true
        data.addDataSet(line2)
        data.setDrawValues(false)
        graphView.data = data
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        // segment control data:graph
        if sender.selectedSegmentIndex == 0 { // if segment on data
            dataTableView.isHidden = false
            addButton.isEnabled = true
            graphView.isHidden = true
            entriesLabel.isHidden = true
        } else if sender.selectedSegmentIndex == 1 { // if segment on graph
            dataTableView.isHidden = true
            addButton.isEnabled = false
            entriesLabel.isHidden = false
            graphView.isHidden = false
            setGraphFeatures()
            switch dataObject {
            case is DC2OverhaulData:
                if DC2OverhaulDataList?.count != 0 {
                    let dataListCopy = DC2OverhaulDataList
                    let object = DC2OverhaulData()
                    entriesLabel.isHidden = false
                    createGraph(list: dataListCopy, object: object, color1: NSUIColor.systemGreen, color2: NSUIColor.red, color3: NSUIColor.link, CFArray1: [UIColor.systemGreen.cgColor, UIColor.clear.cgColor] as CFArray, CFArray2: [UIColor.red.cgColor, UIColor.clear.cgColor] as CFArray, CFArray3: [UIColor.link.cgColor, UIColor.clear.cgColor] as CFArray)
                } else {
                    entriesLabel.isHidden = true
                }
            case is LethsRingsData:
                if LethsRingsDataList?.count != 0 {
                    let dataListCopy = LethsRingsDataList
                    let object = LethsRingsData()
                    createGraph(list: dataListCopy, object: object, color1: NSUIColor.systemGreen, color2: NSUIColor.red, color3: NSUIColor.link, CFArray1: [UIColor.systemGreen.cgColor, UIColor.clear.cgColor] as CFArray, CFArray2: [UIColor.red.cgColor, UIColor.clear.cgColor] as CFArray, CFArray3: [UIColor.link.cgColor, UIColor.clear.cgColor] as CFArray)
                    entriesLabel.isHidden = false
                } else {
                    entriesLabel.isHidden = true
                }
            case is AimTrainingData:
                if AimTrainingDataList?.count != 0 {
                    let dataListCopy = AimTrainingDataList
                    let object = AimTrainingData()
                    createGraph(list: dataListCopy, object: object, color1: NSUIColor.black, color2: NSUIColor.systemGreen, color3: NSUIColor.black, CFArray1: [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray, CFArray2: [UIColor.systemGreen.cgColor, UIColor.clear.cgColor] as CFArray, CFArray3: [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray)
                    entriesLabel.isHidden = false
                }
                entriesLabel.isHidden = true
            case is RankedData:
                if RankedDataList?.count != 0 {
                    let dataListCopy = RankedDataList
                    let object = RankedData()
                    createGraph(list: dataListCopy, object: object, color1: NSUIColor.systemGreen, color2: NSUIColor.red, color3: NSUIColor.black, CFArray1: [UIColor.systemGreen.cgColor, UIColor.clear.cgColor] as CFArray, CFArray2: [UIColor.red.cgColor, UIColor.clear.cgColor] as CFArray, CFArray3: [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray)
                    entriesLabel.isHidden = false
                } else {
                    entriesLabel.isHidden = true
                }
            default:
                print("Error loading list")
            }
        }
    }
}

// MARK: - List View Controller

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // set list count based on which data object list
        switch dataObject {
        case is DC2OverhaulData:
            return DC2OverhaulDataList?.count ?? 0
        case is LethsRingsData:
            return LethsRingsDataList?.count ?? 0
        case is AimTrainingData:
            return AimTrainingDataList?.count ?? 0
        case is RankedData:
            return RankedDataList?.count ?? 0
        default:
            print("Error adding alert")
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as? DataCell else { return UITableViewCell() }
        // set cell based on object
        switch dataObject {
        case is DC2OverhaulData:
            let data = DC2OverhaulDataList![indexPath.row]
            cell.configureThreeEntries(data: data, num: indexPath.row)
        case is LethsRingsData:
            let data = LethsRingsDataList![indexPath.row]
            cell.configureThreeEntries(data: data, num: indexPath.row)
        case is AimTrainingData:
            let data = AimTrainingDataList![indexPath.row]
            cell.configureOneEntry(data: data, num: indexPath.row)
        case is RankedData:
            let data = RankedDataList![indexPath.row]
            cell.configureTwoEntries(data: data, num: indexPath.row)
        default:
            print("Error retrieving data")
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        // deleting data
        switch dataObject {
        case is DC2OverhaulData:
            let data = DC2OverhaulDataList![indexPath.row]
            RealmService.shared.delete(data, table: dataTableView)
        case is LethsRingsData:
            let data = LethsRingsDataList![indexPath.row]
            RealmService.shared.delete(data, table: dataTableView)
        case is AimTrainingData:
            let data = AimTrainingDataList![indexPath.row]
            RealmService.shared.delete(data, table: dataTableView)
        case is RankedData:
            let data = RankedDataList![indexPath.row]
            RealmService.shared.delete(data, table: dataTableView)
        default:
            print("Error")
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // update data if pressed
        switch dataObject {
        case is DC2OverhaulData:
            let data = DC2OverhaulDataList![indexPath.row]
            AlertService.updateAlert(in: self, table: dataTableView, object: data, index: indexPath.row)
        case is LethsRingsData:
            let data = LethsRingsDataList![indexPath.row]
            AlertService.updateAlert(in: self, table: dataTableView, object: data, index: indexPath.row)
        case is AimTrainingData:
            let data = AimTrainingDataList![indexPath.row]
            AlertService.updateAlert(in: self, table: dataTableView, object: data, index: indexPath.row)
        case is RankedData:
            let data = RankedDataList![indexPath.row]
            AlertService.updateAlert(in: self, table: dataTableView, object: data, index: indexPath.row)
        default:
            print("Error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - String Extension

extension String {
    // returns true if string is numerical
    var isInt: Bool {
        return Int(self) != nil
    }
}
