//
//  Single+Nesto.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/29/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift

extension Single {
    
    func subscribeOnBackgroundObserveOnMain() -> PrimitiveSequence<Trait, Element> {
        return subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
}
