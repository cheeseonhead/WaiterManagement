//
//  UIAlertController+QuickMake.swift
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    public class func singleInputAlert(title: String, message: String, confirmAction: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Alert"), style: .cancel, handler: nil)
        let submit = UIAlertAction(title: NSLocalizedString(confirmAction, comment: "Alert"), style: .default, handler: handler)
        
        ac.addAction(cancel)
        ac.addAction(submit)
        
        return ac
    }
}
