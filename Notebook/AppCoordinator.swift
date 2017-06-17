//
//  AppCoordinator.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
}
