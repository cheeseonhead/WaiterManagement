//
//  ShiftScheduler.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-27.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation

class ShiftScheduler {
    
    static func hasConflict(shifts: [Shift], newShift: Shift) -> Bool {
        let newShiftEnd = newShift.end()
        for oldShift in shifts {
            let oldShiftEnd = oldShift.end()
            
            if newShift.start!.isBetween(oldShift.start!, and: oldShiftEnd) || newShiftEnd.isBetween(oldShift.start!, and: oldShiftEnd) {
                return true
            }
        }
        
        return false
    }
    
}

