//
//  ShiftTimePickerViewController.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

protocol ShiftTimePickerViewControllerDelegate: class {
    func choose(startTime: Date, duration: TimeInterval)
}

class ShiftTimePickerViewController: UIViewController {
    
    weak var delegate: ShiftTimePickerViewControllerDelegate?
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIDatePicker!
    
    @IBAction func submitTapped(_ sender: Any) {
        let startDate = startTimePicker.date
        let duration = durationPicker.countDownDuration
        
        dismiss(animated: true) {
            self.delegate?.choose(startTime: startDate, duration: duration)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
