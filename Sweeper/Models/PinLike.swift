//
//  PinLike.swift
//  Sweeper
//
//  Created by Paul Sokolik on 10/16/17.
//  Copyright © 2017 team11. All rights reserved.
//

import Foundation
import Parse

enum PinLikeLiveQueryEventType {
    case like, unlike
}

class PinLike: PFObject, PFSubclassing {
    static let pinIdKey = "likedPinId"
    static let typeKey = "eventType"
    static let likeLiveQueryNotification = Notification.Name("pin-like-livequery")
    static let unlikeLiveQueryNotification = Notification.Name("pin-unlike-livequery")
    static let pinLikeLiveQueryNotification = Notification.Name("pinlike-livequery-notification")
    
    @NSManaged var user: User?
    @NSManaged var likedPin: Pin?
    
    static func parseClassName() -> String {
        return "PinLike"
    }
    
    static func getIdFromNotification(_ notification: Notification) -> String? {
        guard let pinId = notification.userInfo?[pinIdKey] as? String else {
            return nil
        }
        
        return pinId
    }
    
    static func getEventTypeFromNotification(_ notification: Notification) -> PinLikeLiveQueryEventType? {
        guard let type = notification.userInfo?[typeKey] as? PinLikeLiveQueryEventType else {
            return nil
        }
        
        return type
    }
}
