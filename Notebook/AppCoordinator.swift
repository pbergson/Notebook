//
//  AppCoordinator.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit
import CoreData

protocol AppNavigationDelegate: class {
    func showAddNote()
}


class AppCoordinator {
    
    fileprivate let navigationController: UINavigationController
    
    fileprivate let persistentContainer: NSPersistentContainer
    
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
        indexViewController.appNavigationDelegate = self
        
        navigationController.viewControllers = [indexViewController]
    }
}

extension AppCoordinator: AppNavigationDelegate {
    
    func showAddNote() {
        guard let newNoteViewController = R.storyboard.main.newNoteViewController() else {
            assertionFailure("can't create new note view controller")
            return
        }
        
        let noteInteractor = NoteInteractor(container: persistentContainer)
        let newNoteViewModel = NewNoteViewModel(noteInteractor: noteInteractor)
        newNoteViewController.viewModel = newNoteViewModel
        navigationController.present(newNoteViewController, animated: true, completion: nil)
    }
}
