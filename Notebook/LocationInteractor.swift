//
//  LocationInteractor.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/23/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

//The intent behind this class would be to manage a Location object so that users can select from existing locations, as well as responding to taps on a geolocation button, or possibly obtaining gps data from photos.

class LocationInteractor {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    //I wanted to try out the Rx version of the location manager delegates, and this project was a good opportunity. I'm not sure whether I'd stick with them, though.
    
    func getLocation() -> Observable<CLPlacemark> {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            return Observable.error(GeolocationError.locationAuthorizationDenied)
        case .restricted:
            return Observable.error(GeolocationError.locationAuthorizationRestricted)
        default:
            break
        }
        
        let authorizationErrors = locationManager.rx.didChangeAuthorizationStatus
            .flatMap { status -> Observable<CLPlacemark> in
                switch status {
                case .denied:
                    return Observable.error(GeolocationError.locationAuthorizationDenied)
                case .restricted:
                    return Observable.error(GeolocationError.locationAuthorizationRestricted)
                default:
                    return Observable.empty()
                }
        }
        
        let locationUpdates = locationManager.rx.didUpdateLocations
            .take(1)
            .flatMap { locations -> Observable<CLLocation> in
                guard let location = locations.last else {
                    return Observable.error(GeolocationError.coreLocationError(error: nil))
                }
                
                return Observable.just(location)
            }
            .flatMap { [geocoder] location -> Observable<CLPlacemark> in
                Observable.create { observer in
                    geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                        guard let placemark = placemarks?.first, error == nil else {
                            observer.onError(GeolocationError.coreLocationError(error: error))
                            return
                        }
                        
                        observer.onNext(placemark)
                        observer.onCompleted()
                        
                    })
                    
                    return Disposables.create()
                }
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        return Observable.from([authorizationErrors, locationUpdates]).merge()
    }
}

enum GeolocationError: Error {
    case locationAuthorizationDenied
    case locationAuthorizationRestricted
    case coreLocationError(error: Error?)
}
