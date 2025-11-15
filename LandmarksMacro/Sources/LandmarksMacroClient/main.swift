import LandmarksMacro

final class NotificationContent {
    
    let userInfo = [
        "aps": [
            "alert": [
                "title": "TEST TITLE",
                "body": "TEST MESSAGE"
            ] as [String: Any]
        ] as [String: Any],
        "landmarkId": 1001
    ] as [String: Any]
}

@userInfoAccessor
extension NotificationContent {

    private enum UserInfo {
        enum Aps {
            enum Alert {
                case title(String)
                case message(String)
            }
            
            enum Test {
                case test(String)
            }
        }
        case landmarkId(Int)
    }
}

func something(_ instance: NotificationContent) {
    _ = instance.userInfoLandmarkId
}
