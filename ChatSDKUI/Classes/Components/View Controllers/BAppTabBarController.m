//
//  BAppTabBarController.m
//  Chat SDK
//
//  Created by Benjamin Smiley-andrews on 22/05/2014.
//  Copyright (c) 2014 deluge. All rights reserved.
//

#import "BAppTabBarController.h"

#import <ChatSDK/Core.h>
#import <ChatSDK/UI.h>


#define bMessagesBadgeValueKey @"bMessagesBadgeValueKey"

@interface BAppTabBarController ()

@end

@implementation BAppTabBarController

-(instancetype) init {
    if((self = [super init])) {
    }
    return self;
}

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak __typeof__(self) weakSelf = self;
    
    self.delegate = self;
    
    NSArray * vcs = [BChatSDK.ui tabBarNavigationViewControllers];
    self.viewControllers = vcs;
    [self.tabBar setTranslucent:NO];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.toolbarHidden = YES;

    [BChatSDK.hook addHook:[BHook hook:^(NSDictionary * data) {
        [self setSelectedIndex:0];
    }] withName:bHookDidLogout];
    
    [BChatSDK.hook addHook:[BHook hook:^(NSDictionary * data) {
        __typeof(self) strongSelf = weakSelf;
        [strongSelf updateBadge];
    }] withNames:@[bHookMessageRecieved, bHookMessageWasDeleted, bHookAllMessagesDeleted]];
    
    // When a message is recieved we increase the messages tab number
    [[NSNotificationCenter defaultCenter] addObserverForName:bNotificationBadgeUpdated object:Nil queue:Nil usingBlock:^(NSNotification * notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof(self) strongSelf = weakSelf;
            [strongSelf updateBadge];
        });
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:bNotificationThreadRead object:Nil queue:Nil usingBlock:^(NSNotification * notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof(self) strongSelf = weakSelf;
            [strongSelf updateBadge];
        });
    }];
    
    [BChatSDK.hook addHook:[BHook hook:^(NSDictionary * dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof(self) strongSelf = weakSelf;
            [strongSelf updateBadge];
        });
    }] withNames: @[bHookThreadAdded, bHookThreadRemoved]];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:bNotificationPresentChatView object:Nil queue:Nil usingBlock:^(NSNotification * notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Only run this code if this view is visible
            if(BChatSDK.config.shouldOpenChatWhenPushNotificationClicked) {
                if (!BChatSDK.config.shouldOpenChatWhenPushNotificationClickedOnlyIfTabBarVisible || (self.viewIfLoaded && self.viewIfLoaded.window)) {
                    id<PThread> thread = notification.userInfo[bNotificationPresentChatView_PThread];
                    [self presentChatViewWithThread:thread];
                }
            }
        });
    }];
    
    NSInteger badge = [[NSUserDefaults standardUserDefaults] integerForKey:bMessagesBadgeValueKey];
    [self setPrivateThreadsBadge:badge];
    
    [BChatSDK.hook addHook:[BHook hookOnMain:^(NSDictionary * dict) {
        NSString * title = dict[bHook_TitleString];
        NSString * message = dict[bHook_MessageString];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:[NSBundle t:bOk] style:UIAlertActionStyleCancel handler:nil]];
        [self.selectedViewController presentViewController:alert animated:YES completion:nil];
        
    }] withName:bHookGlobalAlertMessage];
    
}

-(void) presentChatViewWithThread: (id<PThread>) thread {
    if(thread) {
        // Set the tab to the private threads screen
        NSArray * vcs = [BChatSDK.ui tabBarViewControllers];
        NSInteger index = [vcs indexOfObject:BChatSDK.ui.privateThreadsViewController];
        
        
        if(index != NSNotFound) {
            [self setSelectedIndex:index];
            UIViewController * chatViewController = [BChatSDK.ui chatViewControllerWithThread:thread];
            
            // Reset navigation stack
            for(UINavigationController * nav in self.viewControllers) {
                if(nav.viewControllers.count) {
                    [nav setViewControllers:@[nav.viewControllers.firstObject] animated: NO];
                }
            }
            
            [((UINavigationController *)self.viewControllers[index]) pushViewController:chatViewController animated:YES];
        }
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBadge];
    [BChatSDK.core save];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Handle push notifications - open the relevant chat
    BBackgroundPushAction * action = BChatSDK.shared.pushQueue.tryFirst;
    if (action && action.type == bPushActionTypeOpenThread) {
        [BChatSDK.shared.pushQueue popFirst];
        NSString * threadEntityID = action.payload[bPushThreadEntityID];
        if (threadEntityID) {
            id<PThread> thread = [BChatSDK.db fetchOrCreateEntityWithID:threadEntityID withType:bThreadEntity];
            [self presentChatViewWithThread:thread];
        }
    }
    
    [self updateBadge];
    
    [BChatSDK.ui setLocalNotificationHandler:^(id<PThread> thread) {
        return NO;
    }];
    [self updateShowLocalNotifications:self.selectedViewController];
}

-(void) updateShowLocalNotifications: (UIViewController *) viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *) viewController;
        if (nav.viewControllers.count) {
            if ([nav.viewControllers.firstObject respondsToSelector:@selector(updateLocalNotificationHandler)]) {
                [nav.viewControllers.firstObject performSelector:@selector(updateLocalNotificationHandler)];
            } else {
                [BChatSDK.ui setLocalNotificationHandler:^(id<PThread> thread) {
                    return YES;
                }];
            }
        }
    }
}

// If the user changes tab they must be online
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [BChatSDK.core save];
    [self updateShowLocalNotifications:viewController];
//    [BChatSDK.core save];
    [self updateBadge];
}

-(void) updateBadge {
    
    [BChatSDK.db privateThreadUnreadMessageCount].thenOnMain(^id(NSNumber * result) {
        [self setPrivateThreadsBadge:result.intValue];
        return nil;
    }, nil);

    // The message view open with this thread?
    // Get the number of unread messages
//    int privateThreadsMessageCount = [self unreadMessagesCount:bThreadFilterPrivate];
//    [self setPrivateThreadsBadge:privateThreadsMessageCount];

    if(BChatSDK.config.showPublicThreadsUnreadMessageBadge) {
        [BChatSDK.db publicThreadUnreadMessageCount].thenOnMain(^id(NSNumber * result) {
            [self setBadge:result.intValue forViewController:BChatSDK.ui.publicThreadsViewController];
            return nil;
        }, nil);

//        int publicThreadsMessageCount = [self unreadMessagesCount:bThreadFilterPublic];
//        [self setBadge:publicThreadsMessageCount forViewController:BChatSDK.ui.publicThreadsViewController];
    }
    
}

// Very expensive in terms of CPU
-(int) unreadMessagesCount: (bThreadType) type {
    
    // Get all the threads
    int i = 0;
    NSArray * threads = [BChatSDK.thread threadsWithType:type];
    for (id<PThread> thread in threads) {

        [BChatSDK.db unreadMessagesCount:thread.entityID].thenOnMain(^id(id result) {
            NSLog(@"Result %@", result);
            return nil;
        }, nil);
        
        i += thread.unreadMessageCount;
    }
    return i;
}

// TODO - move this to a more appropriate place in the code
-(void) setBadge: (int) badge forViewController: (UIViewController *) controller {
    NSInteger index = [BChatSDK.ui.tabBarViewControllers indexOfObject:controller];
    if (index != NSNotFound) {
        // Using self.tabbar will correctly set the badge for the specific index
        NSString * badgeString = badge == 0 ? Nil : [NSString stringWithFormat:@"%i", badge];
        [self.tabBar.items objectAtIndex:index].badgeValue = badgeString;
    }
}

-(void) setPrivateThreadsBadge: (NSInteger) badge {
    [self setBadge:badge forViewController:BChatSDK.ui.privateThreadsViewController];
    
    // Save the value to defaults
    [[NSUserDefaults standardUserDefaults] setInteger:badge forKey:bMessagesBadgeValueKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([BChatSDK.config appBadgeEnabled]) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    }
}

-(NSBundle *) uiBundle {
    return [NSBundle uiBundle];
}

@end
