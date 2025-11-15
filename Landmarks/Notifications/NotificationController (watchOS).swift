//
//  NotificationController.swift
//  Landmarks for watchOS
//
//  Created by とりあえず読書会 on 2025/10/07.
//

import WatchKit
import SwiftUI
import UserNotifications

final class NotificationController: WKUserNotificationHostingController<NotificationView> {
    
    var title: String!
    var message: String!
    var landmarkImage: Landmark.Image?

    override var body: NotificationView {
        NotificationView(title: title, message: message, landmarkImage: landmarkImage)
    }
    
    override func didReceive(_ notification: UNNotification) {
        
        guard let content = NotificationContent(from: notification.request.content) else {
            assertionFailure("予期しないコンテンツが通知されました: \(notification.request.content)")
            
            title = "Unknown landmark"
            message = "I don't know where it is."
            landmarkImage = nil
            
            return
        }
        
        (title, message) = makeTitleAndMessage(with: content)
        landmarkImage = makeLandmarkImage(with: content)
    }
}

private extension NotificationController {
    
    func makeTitleAndMessage(with content: NotificationContent) -> (title: String, message: String) {
        switch (content.userInfoApsAlertTitle, content.userInfoApsAlertMessage) {
            
        case (let title?, let message?):
            (title, message)
            
        case (let title?, nil):
            (title, "The landmark is nearby.")
            
        case (nil, let message?):
            ("A secret landmark", message)
            
        case (nil, nil):
            ("A secret landmark", "The landmark is nearby.")
        }
    }
    
    func makeLandmarkImage(with content: NotificationContent) -> Landmark.Image? {
        
        guard let landmarkId = content.userInfoLandmarkId else {
            assertionFailure("ランドマーク ID が指定されていません。")
            return nil
        }
        
        // FIXME: ここで、Model Data は、このアプリ内で使っているものを使わないといけない。
        let modelData = LandmarksApp.modelData
        
        guard let landmark = modelData.landmarks.element(byID: landmarkId) else {
            assertionFailure("ランドマーク ID のランドマークが見つかりません: ID=\(landmarkId)")
            return nil
        }
        
        guard let title = content.userInfoApsAlertTitle, title == landmark.name else {
            assertionFailure("タイトルの名称と、ランドマーク ID から取得した名称とが一致ません: title=\(content.userInfoApsAlertTitle ?? "(nil)"), landmark name = \(landmark.name)")
            return nil
        }
        
        return landmark.image
    }
}
    
