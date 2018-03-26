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
        
        navigationBar.title = waiter.name
        dataSource = ShiftViewControllerDataSource(waiter: waiter)
    }
    
}

// MARK: - 
