//
//  Date+Compare.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-27.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation

extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        let left = date1 < date2 ? date1 : date2
        let right = date1 < date2 ? date2 : date1
        
        return self > left && self < right
    }
}
