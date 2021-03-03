//
//  RestaurantDataSource.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation

protocol RestaurantDataSourceDelegate: class {
    associatedtype DisplayType
    weak var tableView: UITableView! { get }
    func cell(for item: DisplayType) -> UITableViewCell
}

protocol RestaurantDataSource {
    associatedtype DisplayType: NSManagedObject
    associatedtype Delegate: RestaurantDataSourceDelegate where Delegate.DisplayType == DisplayType
    
    var data: [DisplayType] { get set }
    var manager: RestaurantManager { get set }
    weak var delegate: Delegate? { get set }
    
    func updateData()
}

extension RestaurantDataSource where Self: NSObject {
    
    func delete(at index: Int, callback: (DisplayType) -> Void) {
        guard index < data.count else {
            return
        }
        let item = data[index]
        manager.delete(item)
        manager.save()
        updateData()
        callback(item)
    }
    
    func get(at index: Int) -> DisplayType {
        return data[index]
    }
}

extension RestaurantDataSource where Self: UITableViewDataSource & NSObject {
    
    func numberOfRowsInSection(section: Int) -> Int {
        return data.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        return delegate?.cell(for: data[indexPath.row]) ?? UITableViewCell()
    }
    
    func commit(editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            delete(at: indexPath.row) { _ in
                delegate?.tableView.beginUpdates()
                delegate?.tableView.deleteRows(at: [indexPath], with: .left)
                delegate?.tableView.endUpdates()
            }
        default:
            break
        }
    }
}
