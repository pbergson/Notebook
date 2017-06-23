//
//  ReachabilityService.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/23/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import Foundation

import ReachabilitySwift
import RxSwift

public enum ReachabilityStatus {
    case reachable(viaWiFi: Bool)
    case unreachable
}

public extension ReachabilityStatus {
    public var reachable: Bool {
        switch self {
        case .reachable:
            return true
        case .unreachable:
            return false
        }
    }
}

public protocol ReachabilityDetermining {
    var reachability: Observable<ReachabilityStatus> { get }
}

public class ReachabilityService: ReachabilityDetermining {
    
    public var reachability: Observable<ReachabilityStatus> {
        return reachabilitySubject.asObservable()
    }
    
    private let reachabilitySubject: BehaviorSubject<ReachabilityStatus>
    
    private let reachabilityManager: Reachability
    
    public init() throws {
        guard let reachabilityRef = Reachability() else {
            throw ReachabilityError.FailedToCreateWithHostname("")
        }
        
        let subject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)
        
        // Dispatch to keep these checks off the main thread
        let backgroundQueue = DispatchQueue(label: "reachability.wificheck", attributes: [])
        
        reachabilityRef.whenReachable = { reachability in
            backgroundQueue.async {
                subject.on(.next(.reachable(viaWiFi: reachabilityRef.isReachableViaWiFi)))
            }
        }
        
        reachabilityRef.whenUnreachable = { reachability in
            backgroundQueue.async {
                subject.on(.next(.unreachable))
            }
        }
        
        try reachabilityRef.startNotifier()
        reachabilityManager = reachabilityRef
        reachabilitySubject = subject
    }
    
    deinit {
        reachabilityManager.stopNotifier()
    }
}

public class FallbackReachabilityService: ReachabilityDetermining {
    fileprivate let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .reachable(viaWiFi: true))
    
    public var reachability: Observable<ReachabilityStatus> { return reachabilitySubject.asObservable() }
    
    public init() {}
}

public extension ObservableConvertibleType {
    func retryWhenReachable(usingPlaceholderOnFailure valueOnFailure:E, reachabilityService: ReachabilityDetermining) -> Observable<E> {
        return self.asObservable()
            .catchError {
                
                let retryCodes: Set = [
                    NSURLErrorTimedOut,
                    NSURLErrorNetworkConnectionLost,
                    NSURLErrorNotConnectedToInternet
                ]
                
                let error = $0 as NSError
                
                if error.domain == NSURLErrorDomain && retryCodes.contains(error.code) {
                    return reachabilityService.reachability
                        .filter { $0.reachable }
                        .flatMap { _ in Observable.error(error) }
                        .startWith(valueOnFailure)
                } else {
                    throw error
                }
            }
            .retry(5)
    }
}
