//
//  BHookNotification.m

//
//  Created by Ben on 12/13/18.
//

#import "BHookNotification.h"
#import <ChatSDK/Core.h>

@implementation BHookNotification

+(void) notificationMessageWillSend: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageWillSend data:@{bHook_PMessage: message}];
}

+(void) notificationMessageSending: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageSending data:@{bHook_PMessage: message}];
}

+(void) notificationMessageDidSend: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageDidSend data:@{bHook_PMessage: message}];
}

+(void) notificationMessageWillUpload: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageWillUpload data:@{bHook_PMessage: message}];
}

+(void) notificationMessageDidUpload: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageDidUpload data:@{bHook_PMessage: message}];
}

+(void) notificationMessageDidUpload: (id<PMessage>) message withData: (NSData *) data {
    if (message && data)
        [BChatSDK.hook executeHookWithName:bHookMessageDidUpload data:@{bHook_PMessage: message, bHook_NSData: data}];
}

+(void) notificationMessageDidFailToSend: (NSString *) messageId error: (NSError *) error {
    if (messageId && error)
        [BChatSDK.hook executeHookWithName:bHookMessageDidFailToSend data:@{bHook_StringId: messageId, bHook_NSError: error}];
}

+(void) notificationMessageWillBeDeleted: (id<PMessage>) message {
    if (message)
        [BChatSDK.hook executeHookWithName:bHookMessageWillBeDeleted data:@{bHook_PMessage: message}];
}

+(void) notificationMessageWasDeleted: (NSString *) messageEntityID {
    if (messageEntityID) {
        [BChatSDK.hook executeHookWithName:bHookMessageWasDeleted data:@{bHook_StringId: messageEntityID}];
     }
}

+(void) notificationAllMessagesDeletedForThreads: (NSArray *) threads {
    [BChatSDK.hook executeHookWithName:bHookAllMessagesDeleted data:@{bHook_PThreads: threads}];
}

+(void) notificationMessageReceived: (id<PMessage>) message {
    if (message) {
        [BChatSDK.hook executeHookWithName:bHookMessageRecieved data:@{bHook_PMessage: message}];
    }
}

+(void) notificationDidAuthenticate: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookDidAuthenticate data:@{bHook_PUser: user}];
    }
}

+(void) notificationDidAuthenticate: (id<PUser>) user type: (NSString *) type {
    if (!type) {
        type = bHook_AuthenticationTypeCached;
    }
    [BChatSDK.hook executeHookWithName:bHookDidAuthenticate data:@{bHook_PUser: user, bHook_AuthenticationType: type}];
}

+(void) notificationWillPushUser: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookWillPushUser data:@{bHook_PUser: user}];
    }
}

+(void) notificationWillLogout: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookWillLogout data:@{bHook_PUser:user}];
    }
}

+(void) notificationDidLogout: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookDidLogout data:@{bHook_PUser:user}];
    }
}

+(void) notificationUserOn: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookUserOn data:@{bHook_PUser:user}];
    }
}

+(void) notificationContactWillBeAdded: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookContactWillBeAdded data:@{bHook_PUser:user}];
    }
}

+(void) notificationContactWasAdded: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookContactWasAdded data:@{bHook_PUser:user}];
    }
}

+(void) notificationContactWillBeDeleted: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookContactWillBeDeleted data:@{bHook_PUser:user}];
    }
}

+(void) notificationContactWasDeleted: (id<PUser>) user {
    if (user) {
        [BChatSDK.hook executeHookWithName:bHookContactWasDeleted data:@{bHook_PUser:user}];
    }
}

+(void) notificationInternetConnectivityDidChange {
    [BChatSDK.hook executeHookWithName:bHookInternetConnectivityDidChange data:@{}];
}

+(void) notificationUserWillDisconnect {
    [BChatSDK.hook executeHookWithName:bHookUserWillDisconnect data:@{}];
}

+(void) notificationThreadsUpdated {
    [BChatSDK.hook executeHookWithName:bHookThreadsUpdated data:@{}];
}


+(void) notificationThreadAdded: (id<PThread>) thread {
    if(thread) {
        [BChatSDK.hook executeHookWithName:bHookThreadAdded data:@{bHook_PThread:thread}];
    }
}

+(void) notificationThreadMarkedRead: (id<PThread>) thread {
    if(thread) {
        [BChatSDK.hook executeHookWithName:bHookThreadMarkedRead data:@{bHook_PThread:thread}];
    }
}

+(void) notificationUserLastOnlineUpdated: (id<PUser>) user date: (NSDate *) date {
    if(user && date) {
        [BChatSDK.hook executeHookWithName:bHookUserLastOnlineUpdated data:@{bHook_PUser:user, bHook_NSData: date}];
    }
}


+(void) notificationTypingStateUpdated: (id<PThread>) thread text: (NSString *) text {
    if(thread) {
        if (text) {
            [BChatSDK.hook executeHookWithName:bHookTypingStateUpdated data:@{bHook_PThread:thread, bHook_NSString: text}];
        } else {
            [BChatSDK.hook executeHookWithName:bHookTypingStateUpdated data:@{bHook_PThread:thread}];
        }
    }
}

+(void) notificationMessageReadReceiptUpdated:(id<PMessage>) message {
    if(message) {
        [BChatSDK.hook executeHookWithName:bHookMessageReadReceiptUpdated data:@{bHook_PMessage: message}];
    }
}

+(void) notificationThreadRemoved: (id<PThread>) thread {
    if(thread) {
        [BChatSDK.hook executeHookWithName:bHookThreadRemoved data:@{bHook_PThread:thread}];
    }
}

+(void) notificationThreadUpdated: (id<PThread>) thread {
    if(thread) {
        [BChatSDK.hook executeHookWithName:bHookThreadUpdated data:@{bHook_PThread:thread}];
    }
}

+(void) notificationThreadUsersUpdated: (id<PThread>) thread {
    if(thread) {
        [BChatSDK.hook executeHookWithName:bHookThreadUsersUpdated data:@{bHook_PThread:thread}];
    }
}

+(void) notificationThreadUserRoleUpdated: (id<PThread>) thread user: (id<PUser>) user {
    if (thread && user) {
        if(user) {
            [BChatSDK.hook executeHookWithName:bHookThreadUserRoleUpdated data:@{bHook_PThread: thread, bHook_PUser: user}];
        } else {
            [BChatSDK.hook executeHookWithName:bHookThreadUserRoleUpdated data:@{bHook_PThread: thread}];
        }
    }
}

+(void) notificationUserUpdated: (id<PUser>) user {
    if(user) {
        [BChatSDK.hook executeHookWithName:bHookUserUpdated data:@{bHook_PUser:user}];
    } else {
        [BChatSDK.hook executeHookWithName:bHookUserUpdated data:@{}];
    }
}

+(void) notificationMessageUpdated: (id<PMessage>) message {
    if(message) {
        [BChatSDK.hook executeHookWithName:bHookMessageUpdated data:@{bHook_PMessage:message}];
    }
}

+(void) notificationSilentMessageReceivedWithMessage: (NSObject *) message withMeta: (NSDictionary *) meta {
    if(message && meta) {
        [BChatSDK.hook executeHookWithName:bHookSilentMessageReceived data:@{bHook_RawMessage_NSObject:message, bHook_Meta_NSDictionary: meta}];
    }
}

//+(void) notificationWillResignActive: (UIApplication *) app {
//    [BChatSDK.hook executeHookWithName:bHookWillResignActive data:@{bHook_UIApplication: app}];
//}
//
//+(void) notificationDidBecomeActive: (UIApplication *) app {
//    [BChatSDK.hook executeHookWithName:bHookDidBecomeActive data:@{bHook_UIApplication: app}];
//}
//bHookGlobalAlertMessage

+(void) notificationGlobalAlertMessage: (NSString *) title message: (NSString *) message {
    if (title && message) {
        [BChatSDK.hook executeHookWithName:bHookGlobalAlertMessage data:@{bHook_TitleString: title, bHook_MessageString: message}];
    }
}

+(void) notificationSettingsUpdated: (NSString *) itemId newValue: (id) value {
    if (itemId && value != nil) {
        [BChatSDK.hook executeHookWithName:bHookSettingsUpdated data:@{bHook_StringId: itemId, bHook_ObjectValue: value}];
    }
}

@end
