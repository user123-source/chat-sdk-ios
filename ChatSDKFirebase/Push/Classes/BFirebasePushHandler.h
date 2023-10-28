//
//  BFirebasePushHandler.h
//  XMPPChat
//
//  Created by Benjamin Smiley-andrews on 02/08/2017.
//  Copyright © 2017 deluge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ChatSDK/BAbstractPushHandler.h>
#import <ChatSDK/BBackgroundPushAction.h>

//#import <FirebaseMessaging/FirebaseMessaging.h>
@import FirebaseMessaging;

@class FIRFunctions;

@interface BFirebasePushHandler : BAbstractPushHandler<FIRMessagingDelegate> {
    BOOL _apnsSet;
    NSString * _channel;
    NSMutableArray<FIRMessagingDelegate> * _delegates;
}

@property (nonatomic, readwrite) NSMutableArray<FIRMessagingDelegate> * delegates;

@end

