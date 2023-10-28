//
//  UIButton+Avatar.h

//
//  Created by ben3 on 28/06/2019.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PUser;

@interface UIButton(Avatar)

-(void) loadAvatarForUser: (id<PUser>) user forControlState: (UIControlState) state;
-(UIImage *) userDefaultImage;

@end

NS_ASSUME_NONNULL_END
