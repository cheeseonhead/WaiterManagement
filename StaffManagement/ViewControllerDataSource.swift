//
//  ViewControllerDataSource.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ViewControllerDataSourceDelegate {
    var tableView: UITableView { get }
    func waiterCell(for waiter: Waiter) -> UITableViewCell
}

@objc class ViewControllerDataSource: NSObject {
    
    var waiters: [Waiter] = []
    let manager: RestaurantManager
    let delegate: ViewControllerDataSourceDelegate
    
    init(restaurantManager: RestaurantManager = RestaurantManager.shared(), delegate: ViewControllerDataSourceDelegate) {
        
        manager = restaurantManager
        self.delegate = delegate
        
        super.init()
        
        updateWaiters()
    }
}

// MARK: - Data Manipulation
extension ViewControllerDataSource {
    
    func addWaiter(_ name: String, callback: (Waiter) -> Void) {
        let newWaiter: Waiter = manager.createWaiter(name)
        let curRestaurant = manager.currentRestaurant()
        curRestaurant?.addStaffObject(newWaiter)
        manager.save()
        updateWaiters()
        callback(newWaiter)
    }
    
    func deleteWaiter(at index: Int, callback: (Waiter) -> Void) {
        guard index < waiters.count else {
            return
        }
        let waiter = waiters[index]
        manager.delete(waiter)
        manager.save()
        updateWaiters()
        callback(waiter)
    }
    
    func updateWaiters() {
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        waiters = manager.currentRestaurant().staff.sortedArray(using: [sortByName])
    }
}

// MARK: - TableView Datasource
extension ViewControllerDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waiters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate.waiterCell(for: waiters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteWaiter(at: indexPath.row) { _ in
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
            }
        default:
            break
        }
    }
}
