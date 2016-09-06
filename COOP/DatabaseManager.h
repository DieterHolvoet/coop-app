//
//  DatabaseManager.h
//  COOP
//
//  Created by ontlener on 23/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
+ (DatabaseManager *)sharedManager;
- (void) resetPersistentStores;

@end
