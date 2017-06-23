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
 
    //If I were spending a bit more time on this, I might use RxDataSource, and have this be a driver that's exposed to the view controller, backed by a BehaviorSubject.
    
    let notes = Variable<[Note]>([])
    
    var noteDetail: NoteDetail? = nil

    private let dateFormatter = DateFormatter()
    
    private let noteInteractor: NoteInteractor
    
    private var disposeBag = DisposeBag()
    
    init(noteInteractor: NoteInteractor) {
        
        self.noteInteractor = noteInteractor
        noteInteractor.currentNotes
            .bind(to: notes)
            .disposed(by: disposeBag)

    }
    
    func showNote(at indexPath: IndexPath) {
        
        guard let note = note(for: indexPath) else {
            return
        }
        
        let detail = NoteDetail(note: note, formatter: dateFormatter)
        noteDetail = detail

    }
    
    func note(for indexPath: IndexPath) -> Note? {
        let currentNotes = notes.value
        
        if currentNotes.count > indexPath.row {
            return currentNotes[indexPath.row]
        } else {
            return nil
        }
    }
}
