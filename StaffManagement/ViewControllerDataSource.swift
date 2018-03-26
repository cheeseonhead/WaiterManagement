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
    func waiterCell(for waiter: Waiter) -> UITableViewCell
}

@objc class ViewControllerDataSource: NSObject {
    
    var waiters: [Waiter] = []
    let manager: RestaurantManager
    let delegate: ViewControllerDataSourceDelegate
    
    init(restaurantManager: RestaurantManager = RestaurantManager.shared(), delegate: ViewControllerDataSourceDelegate) {
        
        manager = restaurantManager
        self.delegate = delegate
        
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
            waiters.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        default:
            break
        }
    }
    
}
