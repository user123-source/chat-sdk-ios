//
//  BHookNotification.h

//
//  Created by Ben on 12/13/18.
//

#import <Foundation/Foundation.h>

@protocol PUser;
@protocol PThread;
@protocol PMessage;

@interface BHookNotification : NSObject

+(void) notificationMessageWillSend: (id<PMessage>) message;
+(void) notificationMessageSending: (id<PMessage>) message;
+(void) notificationMessageDidSend: (id<PMessage>) message;
+(void) notificationMessageWillUpload: (id<PMessage>) message;
+(void) notificationMessageDidUpload: (id<PMessage>) message;
+(void) notificationMessageDidUpload: (id<PMessage>) message withData: (NSData *) data;
+(void) notificationMessageUpdated: (id<PMessage>) message;
+(void) notificationMessageDidFailToSend: (NSString *) messageId error: (NSError *) error;

+(void) notificationMessageReceived: (id<PMessage>) message;

+(void) notificationContactWillBeAdded: (id<PUser>) user;
+(void) notificationContactWasAdded: (id<PUser>) user;
+(void) notificationContactWillBeDeleted: (id<PUser>) user;
+(void) notificationContactWasDeleted: (id<PUser>) user;

+(void) notificationMessageWillBeDeleted: (id<PMessage>) message;
+(void) notificationMessageWasDeleted: (NSString *) messageEntityID;

+(void) notificationDidAuthenticate: (id<PUser>) user type: (NSString *) type;
+(void) notificationWillLogout: (id<PUser>) user;
+(void) notificationDidLogout: (id<PUser>) user;
+(void) notificationUserOn: (id<PUser>) user;
+(void) notificationInternetConnectivityDidChange;
+(void) notificationUserWillDisconnect;
+(void) notificationAllMessagesDeletedForThreads: (NSArray *) threads;

+(void) notificationThreadsUpdated;
+(void) notificationThreadAdded: (id<PThread>) thread;
+(void) notificationThreadRemoved: (id<PThread>) thread;
+(void) notificationThreadUpdated: (id<PThread>) thread;
+(void) notificationThreadUsersUpdated: (id<PThread>) thread;
+(void) notificationThreadUserRoleUpdated: (id<PThread>) thread user: (id<PUser>) user;
+(void) notificationThreadMarkedRead: (id<PThread>) thread;
+(void) notificationMessageReadReceiptUpdated:(id<PMessage>) message;

+(void) notificationSettingsUpdated: (NSString *) itemId newValue: (id) value;
+(void) notificationSilentMessageReceivedWithMessage: (NSObject *) message withMeta: (NSDictionary *) meta;

+(void) notificationWillPushUser: (id<PUser>) user;
+(void) notificationUserUpdated: (id<PUser>) user;
+(void) notificationUserLastOnlineUpdated: (id<PUser>) user date: (NSDate *) date;

+(void) notificationTypingStateUpdated: (id<PThread>) thread text: (NSString *) text;

//+(void) notificationWillResignActive: (UIApplication *) app;
//+(void) notificationDidBecomeActive: (UIApplication *) app;

+(void) notificationGlobalAlertMessage: (NSString *) title message: (NSString *) message;

@end
