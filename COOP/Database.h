//
//  Database.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Walk.h"

@interface Database : NSObject

+ (Walk*) fetchWalkFromContextWithID: (int)id;
+ (NSArray*) getSortedStopsArrayWithPOIs:(NSSet*)pois andWaypoints:(NSSet*)waypoints;
+ (NSArray*) fetchWalkListFromContext;
+ (NSArray*) fetchThemeListFromContext;
+ (void) deleteCache;
+ (void) setWalkFinished:(Walk*)walk;
+ (NSArray*) getFinishedWalks;

@end
