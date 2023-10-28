//
//  BMapViewManager.h

//
//  Created by Ben on 3/16/18.
//

#import <Foundation/Foundation.h>

@class BMapViewWrapper;

@interface BMapViewManager : NSObject {
    NSMutableArray * _mapPool;
}

+(BMapViewManager *) shared;
-(BMapViewWrapper *) mapFromPool;
-(void) returnToPool: (BMapViewWrapper *) map;

@end
