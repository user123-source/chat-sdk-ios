//
//  PStickersHandler.h
//  Pods
//
//  Created by Benjamin Smiley-andrews on 16/12/2016.
//
//

#ifndef PStickersHandler_h
#define PStickersHandler_h

@class RXPromise;

@protocol PStickerMessageHandler <NSObject>

-(RXPromise *) sendMessageWithSticker: (NSString *) stickerName url: (NSString *) url threadEntityID: (NSString *) threadID;

-(Class) cellClass;
-(UIImage *) imageForName: (NSString *) name;

@end

#endif /* PStickersHandler_h */
