//
//  ShiftViewControllerDataSource.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

class ShiftViewControllerDataSource: NSObject, UITableViewDataSource {
    
    let waiter: Waiter
    let manager: RestaurantManager
//    var shifts: 
    
    init(waiter: Waiter, manager: RestaurantManager) {
        self.waiter = waiter
        self.manager = manager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Data Manipulation
extension ShiftViewControllerDataSource {
    func addShift(start: Date, end: Date) {
        let shift = manager.createShift(start, end: end)
        
    }
}
