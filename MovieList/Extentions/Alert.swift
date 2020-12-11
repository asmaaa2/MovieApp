//
//  Alert.swift
//  MovieList
//
//  Created by Elattar on 3/11/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, massage: String)  {
        
        let actionAlert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(actionAlert, animated: true, completion: nil)
    }
}
