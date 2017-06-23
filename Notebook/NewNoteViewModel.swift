//
//  NewNoteViewModel.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/17/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit
import RxSwift

class NewNoteViewModel {
    
    let titleText: AnyObserver<String?>
    let bodyText: AnyObserver<String?>
    let saveTaps: AnyObserver<Void>
    let geolocateTaps: AnyObserver<Void>
    
    private let noteInteractor: NoteInteractor
    private var disposeBag = DisposeBag()
    
    init(noteInteractor: NoteInteractor) {
        self.noteInteractor = noteInteractor
        
        let _titleText = BehaviorSubject<String?>(value: nil)
        titleText = _titleText.asObserver()
        
        _titleText.asObservable()
            .subscribe(onNext: { (text) in
                if let text = text {
                    print(text)
                }
            })
            .disposed(by: disposeBag)
        
        let _bodyText = BehaviorSubject<String?>(value: nil)
        bodyText = _bodyText.asObserver()
        
        _bodyText.asObservable()
            .subscribe(onNext: { (text) in
                if let text = text {
                    print(text)
                }
            })
            .disposed(by: disposeBag)
        
        let _saveTaps = PublishSubject<Void>()
        
        let noteDrafts = Observable.combineLatest(_titleText.asObservable(), _bodyText.asObservable()) { (title, body)  in
            return NoteDraft(title: title ?? "", body: body ?? "", date: Date(), author: "Pamela")
        }
        
        saveTaps = _saveTaps.asObserver()
        
        _saveTaps.asObservable()
            .withLatestFrom(noteDrafts)
            .subscribe(onNext: { [noteInteractor] draft in
                noteInteractor.createNote(with: draft)
            })
            .disposed(by: disposeBag)
        
        let _geolocateTaps = PublishSubject<Void>()
        geolocateTaps = _geolocateTaps.asObserver()
        
    }
    

}
