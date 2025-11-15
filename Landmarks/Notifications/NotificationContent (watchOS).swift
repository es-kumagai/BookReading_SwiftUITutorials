//
//  NotificationContent.swift
//  Landmarks for watchOS
//
//  Created by とりあえず読書会 on 2025/10/08.
//

import UserNotifications
import LandmarksMacro

struct NotificationContent {
    let userInfo: [String: Any]
    
    init?(from content: UNNotificationContent) {
        guard let userInfo = content.userInfo as? [String: Any] else {
            return nil
        }
        
        self.userInfo = userInfo
    }
}

@userInfoAccessor
extension NotificationContent {
    
    enum UserInfo {
        enum Aps {
            enum Alert {
                case title(String)
                case message(String)
            }
        }
        case landmarkId(Int)
    }
}
