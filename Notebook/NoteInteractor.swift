//
//  NoteInteractor.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/17/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class NoteInteractor: NSObject, NSFetchedResultsControllerDelegate {
    
    private let persistentContainer: NSPersistentContainer
    private let fetchedResultsController: NSFetchedResultsController<Note>
    
    let currentNotes: Observable<[Note]>
    private let _notes = BehaviorSubject<[Note]>(value: [])
    init(container: NSPersistentContainer) {
        
        self.persistentContainer = container
        currentNotes = _notes.asObservable()
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        do {
            try fetchedResultsController.performFetch()
            if let results = fetchedResultsController.fetchedObjects {
                _notes.onNext(results)
            }
        } catch {
            assertionFailure("couldn't perform initial fetch for notes")
        }
        
        self.fetchedResultsController.delegate = self
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let results = fetchedResultsController.fetchedObjects {
            _notes.onNext(results)
        }
    }
}
