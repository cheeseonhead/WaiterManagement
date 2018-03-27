//
//  ShiftViewControllerDataSource.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

class ShiftViewControllerDataSource: NSObject, RestaurantDataSource {
    
    typealias MainType = Waiter
    typealias DisplayType = Shift
    typealias Delegate = ShiftViewController
    
    
    let waiter: Waiter
    var manager: RestaurantManager
    weak var delegate: Delegate?
    var data: [Shift] = []
    
    init(waiter: Waiter, manager: RestaurantManager, delegate: Delegate) {
        self.waiter = waiter
        self.manager = manager
        self.delegate = delegate
        super.init()

        updateData()
    }
}

// MARK: - Data Manipulation
extension ShiftViewControllerDataSource {
    
    func addShift(start: Date, duration: TimeInterval, callback: (Shift) -> Void) {
        let shift = manager.createShift(start, duration: duration)!
        waiter.addShiftObject(shift)
        manager.save()
        updateData()
        callback(shift)
    }
    
    func updateData() {
        data = waiter.shift!.sorted(by: <)
    }
}

// MARK: - TableView Datasource
extension ShiftViewControllerDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        commit(editingStyle: editingStyle, forRowAt: indexPath)
    }
}
