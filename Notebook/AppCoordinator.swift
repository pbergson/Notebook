//
//  AppCoordinator.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit
import CoreData


class AppCoordinator {
    
    private let navigationController: UINavigationController
    
    private let persistentContainer: NSPersistentContainer
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let store = NSPersistentContainer(name: "Notebook")
        self.persistentContainer = store
        
        guard let indexViewController = R.storyboard.main.indexViewController() else {
            assertionFailure("can't create index view controller")
            return
        }
        
        let noteInteractor = NoteInteractor(container: self.persistentContainer)
        let indexViewModel = IndexViewModel(noteInteractor: noteInteractor)
        indexViewController.viewModel = indexViewModel
        
        navigationController.viewControllers = [indexViewController]
    }
    
 
        
}
