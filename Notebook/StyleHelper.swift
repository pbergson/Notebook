//
//  StyleHelper.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/20/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

struct StyleHelper {
    
    static var notebookGreen = UIColor(red: 0/255, green: 128/255, blue: 64/255, alpha: 1)

    static func applyStyle(to navController: UINavigationController) {
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navController.navigationBar.barTintColor = StyleHelper.notebookGreen
    }
}
