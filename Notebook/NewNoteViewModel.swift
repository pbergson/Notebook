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
    private let locationInteractor: LocationInteractor
    private var disposeBag = DisposeBag()
    
    init(noteInteractor: NoteInteractor) {
        self.noteInteractor = noteInteractor
        self.locationInteractor = LocationInteractor()
        
        let _titleText = BehaviorSubject<String?>(value: nil)
        titleText = _titleText.asObserver()
        
        let _bodyText = BehaviorSubject<String?>(value: nil)
        bodyText = _bodyText.asObserver()
        
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
        
        _geolocateTaps.asObservable()
            .flatMap { [locationInteractor] _ in
                return locationInteractor.getLocation()
            }
            .subscribe(onNext: { (location) in
                //I invision using the returned location to populate the UI, but probably not as a placemark - I'd implement a Location type like the Note type.
                
                print(location)
            }, onError: { (error) in
                //this is where I should prompt for permissions and navigate to settings as necessary
                print(error)
            })
            .disposed(by: disposeBag)
    }
    

}
