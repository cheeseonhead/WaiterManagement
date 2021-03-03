//
//  SequenceType+Sort.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation

extension Collection where Element: Any {
    public func sortedArray(using descriptors: [NSSortDescriptor]) -> [Self.Element] {
        return sorted {
            for descriptor in descriptors {
                switch descriptor.compare($0, to: $1) {
                case .orderedAscending:
                    return true
                case .orderedSame:
                    continue
                case .orderedDescending:
                    return false
                }
            }
            return false
        }
    }
}
