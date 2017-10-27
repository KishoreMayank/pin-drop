//
//  AppService.swift
//  Sweeper
//
//  Created by Paul Sokolik on 10/14/17.
//  Copyright © 2017 team11. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseLiveQuery

class AppService {
    static let sharedInstance = AppService()
    
    let client: Client = Client.shared
    private let pinLikeQuery = PinLike.query()!.whereKeyExists("user").order(byAscending: "createdAt") as! PFQuery<PinLike>
    private var pinLikeSubscription: Subscription<PinLike>?
    private lazy var pinLikeSubscriptionCreator = { () -> Subscription<PinLike> in
        let subscription = self.client.subscribe(self.pinLikeQuery).handleEvent({ (query, event) in
            switch event {
            case .created(let pinLike):
                self.pinLikeLiveQueryHandler(pinLike, type: .like)
            case .deleted(let pinLike):
                self.pinLikeLiveQueryHandler(pinLike, type: .unlike)
            default:
                break
            }
        })
        return subscription
    }
    
    private init() {}
    
    func createPinLikeSubscription() {
        if pinLikeSubscription == nil {
            pinLikeSubscription = pinLikeSubscriptionCreator()
        }
    }
    
    func unsubscribePinLikes() {
        if pinLikeSubscription != nil {
            client.unsubscribe(pinLikeQuery as! PFQuery<PFObject>)
            pinLikeSubscription = nil
        }
    }
    
    private func pinLikeLiveQueryHandler(_ pinLike: PinLike, type: PinLikeLiveQueryEventType) {
        if let likedPinId = pinLike.likedPin?.objectId {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: PinLike.pinLikeLiveQueryNotification,
                                                object: nil,
                                                userInfo: [PinLike.pinIdKey: likedPinId, PinLike.typeKey: type])
            }
        }
    }
}
