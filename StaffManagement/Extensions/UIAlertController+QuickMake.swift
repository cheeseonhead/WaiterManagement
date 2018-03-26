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
    public class func singleInputAlert(title: String, message: String, confirmTitle: String, placeHolder: String?, handler: ((String) -> Void)?) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addTextField { (textfield) in
            textfield.placeholder = placeHolder
        }
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Alert"), style: .cancel, handler: nil)
        let submit = UIAlertAction(title: NSLocalizedString(confirmTitle, comment: "Alert"), style: .default) {
            _ in
            let input = ac.textFields?.first?.text ?? ""
            handler?(input)
        }
        
        ac.addAction(cancel)
        ac.addAction(submit)
        
        return ac
    }
}
