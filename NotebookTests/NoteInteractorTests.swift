//
//  NoteInteractorTests.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/17/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import XCTest
import CoreData
import RxSwift
import RxCocoa
@testable import Notebook

class NoteInteractorTests: XCTestCase {

    func testFetchedResultsController() {

        let store = inMemoryStore()
        let disposeBag = DisposeBag()
        
        let note = Note(context: store.viewContext)
        note.title = "foo"
        note.createdAt = NSDate().addingTimeInterval(-2)
        
        let secondNote = Note(context: store.viewContext)
        secondNote.title = "bar"
        secondNote.createdAt = NSDate().addingTimeInterval(-1)
        
        let interactor = NoteInteractor(container: store)
        let expectation = self.expectation(description: "next")
        
        interactor.currentNotes
        .subscribe(onNext: { (notes) in
            expectation.fulfill()
            XCTAssert(notes.count == 2, "wrong number of notes")
            
            let one = notes[0]
            XCTAssert(one.title == "foo", "expected foo")
            
            let two = notes[1]
            XCTAssert(two.title == "bar", "expected bar")
            
        }, onError: { (error) in
            XCTFail("failed with error: \(error)")
        })
        .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
    func inMemoryStore() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Notebook")
        let description = NSPersistentStoreDescription()
        description.configuration = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (_, error) in
            if error != nil {
                XCTFail("couldn't make in memory store")
            }
        }
        
        return container
    }
    
}
