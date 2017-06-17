//
//  IndexViewModel.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class IndexViewModel {
 
    //If I were spending a bit more time on this, I would probably use RxDataSource, and have this be a driver that's exposed to the view controller, backed by a BehaviorSubject.
    
    let notes = Variable<[NoteDraft]>([])
    
    init() {
        
        let firstNote = NoteDraft(title: "first note", date: Date(), author: "Pamela")
        notes.value = [firstNote]
        
    }
    
    func note(for indexPath: IndexPath) -> NoteDraft? {
        let currentNotes = notes.value
        
        if currentNotes.count > indexPath.row {
            return currentNotes[indexPath.row]
        } else {
            return nil
        }
    }
}
