//
//  Database.m
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Database.h"
#import "DatabaseManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation Database

#pragma mark - Public methods

+ (Walk*) fetchWalkFromContextWithID: (int)id {
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Walk"];
    NSError *error = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"walk_id == %d", id]];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if(results == nil || results.count == 0) {
        return nil;
        
    } else {
        Walk *walk = [results firstObject];
        walk.stops = [Database getSortedStopsArrayWithPOIs:walk.pois andWaypoints:walk.waypoints];
        return walk;
    }
}

+ (NSArray*) getSortedStopsArrayWithPOIs:(NSSet*)pois andWaypoints:(NSSet*)waypoints {
    NSSet* stops = [pois setByAddingObjectsFromSet:waypoints];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"stop_sequence" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    
    return [stops sortedArrayUsingDescriptors:sortDescriptors];
}

+ (NSArray*) fetchWalkListFromContext {
    return [Database fetchAllWithEntityName:@"Walk" andSortKey:@"walk_id"];
}

+ (NSArray*) fetchThemeListFromContext {
    return [Database fetchAllWithEntityName:@"Theme" andSortKey:@"theme_id"];
}

+ (void) deleteCache {
    // RestKit and Core Data
    [[DatabaseManager sharedManager] resetPersistentStores];
    
    // SDWebImage
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
}

+ (void) setWalkFinished:(Walk*)walk {
    NSMutableArray *finishedWalks = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"finishedWalks"]];
    [finishedWalks addObject:[walk.walk_id copy]];
    [[NSUserDefaults standardUserDefaults] setObject:[[NSSet setWithArray:finishedWalks] allObjects] forKey:@"finishedWalks"];
    walk.isCleared = [NSNumber numberWithBool:YES];
}

+ (NSArray*) getFinishedWalks {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"finishedWalks"] allObjects];
}

#pragma mark - Private methods

+ (NSArray*) fetchAllWithEntityName:(NSString*)name andSortKey:(NSString*)sortKey {
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    NSError *error = nil;
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES]];
    
    return [context executeFetchRequest:fetchRequest error:&error];
}

@end
