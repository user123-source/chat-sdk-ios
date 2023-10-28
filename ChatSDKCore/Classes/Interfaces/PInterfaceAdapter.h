//
//  PInterfaceAdapter.h
//  Pods
//
//  Created by Benjamin Smiley-andrews on 14/12/2016.
//
//

#ifndef PInterfaceAdapter_h
#define PInterfaceAdapter_h

@protocol PUser;
@protocol PThread;
@protocol PChatOptionsHandler;
@protocol PSearchViewController;
@protocol PSendBar;
@protocol BChatOptionDelegate;
@protocol PImageViewController;
@protocol PLocationViewController;
@protocol PSplashScreenViewController;
@protocol PProvider;
@protocol PModerationViewController;

@class BChatViewController;
@class BFriendsListViewController;
@class BChatOption;
@class BTextInputView;
@class BLocalNotificationHandler;
@class SettingsSection;
@class BDetailedEditProfileTableViewController;
@class BDetailedProfileTableViewController;

typedef UIViewController * (^UserProvider) (id<PUser> user);
typedef UIViewController * (^ChatProvider) (id<PThread> thread);
typedef UIViewController<PModerationViewController> * (^ModerationProvider) (id<PThread> thread, id<PUser> user);

@protocol PInterfaceAdapter <NSObject>

-(void) setPrivateThreadsViewController: (UIViewController *) controller;
-(UIViewController *) privateThreadsViewController;

-(void) setPublicThreadsViewController: (UIViewController *) controller;
-(UIViewController *) publicThreadsViewController;

-(void) setEditThreadsViewController: (UIViewController *) controller;
-(UIViewController *) editThreadsViewController: (id<PThread>) thread didSave: (void(^)()) callback;

-(void) setContactsViewController: (UIViewController *) controller;
-(UIViewController *) contactsViewController;

-(void) setProfileViewController: (UserProvider) provider;
-(UIViewController *) profileViewControllerWithUser: (id<PUser>) user;

-(void) setModerationViewController: (ModerationProvider) provider;
-(UIViewController<PModerationViewController> *) moderationViewControllerWithThread: (id<PThread>) thread withUser: (id<PUser>) user;

-(void) setProfilePicturesViewController: (UserProvider) provider;
-(UIViewController *) profilePicturesViewControllerWithUser: (id<PUser>) user;

-(void) setProfileOptionsViewController: (UserProvider) provider;
-(UIViewController *) profileOptionsViewControllerWithUser: (id<PUser>) user;

-(void) setEditProfileViewController: (BDetailedEditProfileTableViewController *) controller;
-(UIViewController *) editProfileViewControllerWithParent: (BDetailedProfileTableViewController *) parent;

-(void) setSettingsViewController: (UIViewController *) controller;
-(UIViewController *) settingsViewController;

-(void) setMainViewController: (UIViewController *) controller;
-(UIViewController *) mainViewController;

-(void) setTermsOfServiceViewController: (UIViewController *) controller;
-(UIViewController *) termsOfServiceViewController;
-(UINavigationController *) termsOfServiceNavigationController;

// Use termsOfServiceViewController instead
-(UIViewController *) eulaViewController __deprecated;

// Use termsOfServiceNavigationController instead
-(UINavigationController *) eulaNavigationController __deprecated;

-(void) setFriendsListViewController: (BFriendsListViewController * (^)(NSArray<PUser> * usersToExclude, void(^onComplete)(NSArray<PUser> * users, NSString * groupName, UIImage * image))) provider;

-(BFriendsListViewController *) friendsViewControllerWithUsersToExclude: (NSArray<PUser> *) usersToExclude onComplete: (void(^)(NSArray<PUser> * users, NSString * name, UIImage * image)) action;

-(UINavigationController *) friendsNavigationControllerWithUsersToExclude: (NSArray<PUser> *) usersToExclude onComplete: (void(^)(NSArray<PUser> * users, NSString * name, UIImage * image)) action;

-(void) setChatViewController: (ChatProvider) provider;
-(UIViewController *) chatViewControllerWithThread: (id<PThread>) thread;

-(NSArray *) defaultTabBarViewControllers;
-(UIView<PSendBar> *) sendBarView;

-(void) setSearchViewController: (UIViewController * (^)(NSArray * usersToExclude, void(^usersAdded)(NSArray * users))) provider;
-(UIViewController *) searchViewControllerWithType: (NSString *) type excludingUsers: (NSArray *) users usersAdded: (void(^)(NSArray * users)) usersAdded;
-(UIViewController<PSearchViewController> *) searchViewControllerExcludingUsers: (NSArray *) users usersAdded: (void(^)(NSArray * users)) usersAdded;

-(void) addSearchViewController: (UIViewController<PSearchViewController> *) controller withType: (NSString *) type withName: (NSString *) name;
-(void) removeSearchViewControllerWithType: (NSString *) type;

-(void) setChatOptionsHandler: (id<PChatOptionsHandler>) handler;

-(NSArray *) tabBarViewControllers;
-(NSArray *) tabBarNavigationViewControllers;

-(NSMutableArray *) chatOptions;
-(id<PChatOptionsHandler>) chatOptionsHandlerWithDelegate: (id<BChatOptionDelegate>) delegate;

-(void) setUsersViewController: (UIViewController * (^)(id<PThread> thread, UINavigationController * parent)) provider;
-(UIViewController *) usersViewControllerWithThread: (id<PThread>) thread parentNavigationController: (UINavigationController *) parent;
-(UINavigationController *) usersViewNavigationControllerWithThread: (id<PThread>) thread parentNavigationController: (UINavigationController *) parent;

-(void) addChatOption: (BChatOption *) option;
-(void) removeChatOption: (BChatOption *) option;
-(void) removeChatOptionWithTitle: (NSString *) title;

-(void) addSettingsSection: (SettingsSection *) section;
-(NSArray *) settingsSections;

-(void) addTabBarViewController: (UIViewController *) controller atIndex: (int) index;
-(void) removeTabBarViewControllerAtIndex: (int) index;

-(NSDictionary *) additionalSearchControllerNames;
-(UIViewController *) settingsViewController;

-(UIColor *) colorForName: (NSString *) name;

-(BOOL) showLocalNotification: (id<PThread>) thread;
-(void) setLocalNotificationHandler:(BOOL(^)(id<PThread>)) handler;

-(void) setImageViewController: (UIViewController *) controller;
-(UIViewController<PImageViewController> *) imageViewController;
-(UINavigationController *) imageViewNavigationController;

-(void) setLocationViewController: (UIViewController *) controller;
-(UIViewController<PLocationViewController> *) locationViewController;
-(UINavigationController *) locationViewNavigationController;

-(void) setSearchIndexViewController: (UIViewController * (^)(NSArray * indexes, void(^callback)(NSArray *))) provider;
-(UIViewController *) searchIndexViewControllerWithIndexes: (NSArray *) indexes withCallback: (void(^)(NSArray *)) callback;
-(UINavigationController *) searchIndexNavigationControllerWithIndexes: (NSArray *) indexes withCallback: (void(^)(NSArray *)) callback;

-(void) setSplashScreenViewController: (UIViewController<PSplashScreenViewController> *) controller;
-(UIViewController<PSplashScreenViewController> *) splashScreenViewController;
-(UINavigationController *) splashScreenNavigationController;

-(void) setLoginViewController: (UIViewController *) controller;
-(UIViewController *) loginViewController;

-(void) registerMessageWithCellClass: (Class) cellClass messageType: (NSNumber *) type;
-(NSArray *) messageCellTypes;
-(Class) cellTypeForMessageType: (NSNumber *) messageType;

-(id<PProvider>) providerForName: (NSString *) name;
-(void) setProvider: (id<PProvider>) provider forName: (NSString *) name;

@end


#endif /* PInterfaceAdapter_h */
