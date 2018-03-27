//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

class ShiftViewController: UIViewController {
    
    // MARK: - Constants
    let CELL_REUSE_IDENTIFIER = "shiftCell"
    
    // MARK: - Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // MARK: States
    var waiter: Waiter!
    var dataSource: ShiftViewControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard waiter != nil else {
            return
        }
        
        dataSource = ShiftViewControllerDataSource(waiter: waiter, manager: RestaurantManager.shared(), delegate: self)
        
        navigationBar.title = waiter.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_IDENTIFIER)
    }
}

// MARK: - Data Source Delegate
extension ShiftViewController: ShiftVCDataSourceDelegate {
    func cell(for shift: Shift) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER)!
        cell.textLabel?.text = format(shift: shift)
        
        return cell
    }
}

// MARK: - Helper
extension ShiftViewController {
    func format(shift: Shift) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        var resp = formatter.string(from: shift.start!)
        resp += formatter.string(from: shift.end!)
        
        return resp
    }
}
