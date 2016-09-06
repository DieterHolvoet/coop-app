//
//  API.h
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

+ (void) loadWalkWithID: (int)id andSuccess:(WalkSuccessBlock)success andFailure:(FailureBlock)failure andActivityIndicator:(UIActivityIndicatorView*)indicator;
+ (void) loadWalkListwithSuccess:(WalkListSuccessBlock)success andFailure:(FailureBlock)failure;
+ (void) loadThemeListwithSuccess:(ThemeListSuccessBlock)success andFailure:(FailureBlock)failure;
+ (void) loadImageWithURL:(NSURL*)url andSuccess:(ImageSuccessBlock)success andFailure:(FailureBlock)failure;

@end
