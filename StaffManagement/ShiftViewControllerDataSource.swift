//
//  ShiftViewControllerDataSource.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

protocol ShiftVCDataSourceDelegate: class {
    func cell(for shift: Shift) -> UITableViewCell
}

class ShiftViewControllerDataSource: NSObject {
    
    let waiter: Waiter
    let manager: RestaurantManager
    weak var delegate: ShiftVCDataSourceDelegate?
    var shifts: [Shift] = []
    
    init(waiter: Waiter, manager: RestaurantManager, delegate: ShiftVCDataSourceDelegate) {
        self.waiter = waiter
        self.manager = manager
        self.delegate = delegate
        super.init()
        
        updateShifts()
    }
}

// MARK: - Data Manipulation
extension ShiftViewControllerDataSource {
    func addShift(start: Date, duration: TimeInterval, callback: (Shift) -> Void) {
        let shift = manager.createShift(start, duration: duration)!
        waiter.addShiftObject(shift)
        manager.save()
        updateShifts()
        callback(shift)
    }
    
    func deleteShift(at index: Int, callback: (Shift) -> Void) {
        let shift = shifts[index]
        manager.delete(shift)
        manager.save()
        updateShifts()
        callback(shift)
    }
    
    func updateShifts() {
        shifts = waiter.shift!.sorted(by: { (left, right) -> Bool in
            return left.start! == right.start! ? left.start! < right.start! : left.duration!.doubleValue < right.duration!.doubleValue
        })
    }
}

// MARK: - TableView Datasource
extension ShiftViewControllerDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = delegate else { return UITableViewCell() }
        
        return delegate.cell(for: shifts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteShift(at: indexPath.row) { _ in
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
            }
        default:
            break
        }
    }
}
