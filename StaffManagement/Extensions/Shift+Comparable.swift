//
//  Shift+Comparable.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-27.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation

extension Shift: Comparable {
    public static func <(lhs: Shift, rhs: Shift) -> Bool {
        if lhs.start! == rhs.start! {
            return lhs.end() < rhs.end()
        } else {
            return lhs.start! < rhs.start!
        }
    }
}
