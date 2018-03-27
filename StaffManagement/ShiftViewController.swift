//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

class ShiftViewController: UIViewController {
    
    // MARK: - Constants
    let kShiftCellIdentifier = "shiftCell"
    
    // MARK: - Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // MARK: States
    var waiter: Waiter!
    var dataSource: ShiftViewControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard waiter != nil else {
            return
        }
        
        dataSource = ShiftViewControllerDataSource(waiter: waiter, manager: RestaurantManager.shared(), delegate: self)
        tableView.dataSource = dataSource
        
        navigationBar.title = waiter.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kShiftCellIdentifier)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let pickerVC = UIStoryboard.init(name: "ShiftTimePickerViewController", bundle: nil).instantiateInitialViewController() as! ShiftTimePickerViewController
        pickerVC.delegate = self
        
        pickerVC.modalPresentationStyle = .formSheet
        
        present(pickerVC, animated: true, completion: nil)
    }
}

// MARK: - Data Source Delegate
extension ShiftViewController: RestaurantDataSourceDelegate {
    
    typealias DisplayType = Shift
    
    func cell(for shift: Shift) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kShiftCellIdentifier)!
        cell.textLabel?.text = format(shift: shift)
        
        return cell
    }
}

// MARK: - Picker Delegate
extension ShiftViewController: ShiftTimePickerViewControllerDelegate {
    func choose(startTime: Date, duration: TimeInterval) {
        dataSource.addShift(start: startTime, duration: duration) { _ in
            tableView.reloadData()
        }
    }
}

// MARK: - Helper
extension ShiftViewController {
    func format(shift: Shift) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        var resp = "\(formatter.string(from: shift.start!)) to "
        formatter.dateStyle = .none
        resp += "\(formatter.string(from: shift.end()))"
        
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.unitsStyle = .abbreviated
        durationFormatter.allowedUnits = [.minute, .hour]

        resp += " (\(durationFormatter.string(from: Double(shift.duration!)) ?? ""))"
        
        return resp
    }
}
