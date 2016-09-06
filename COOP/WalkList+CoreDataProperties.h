//
//  WalkList+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WalkList.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalkList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<Walk *> *walks;

@end

@interface WalkList (CoreDataGeneratedAccessors)

- (void)addWalksObject:(Walk *)value;
- (void)removeWalksObject:(Walk *)value;
- (void)addWalks:(NSSet<Walk *> *)values;
- (void)removeWalks:(NSSet<Walk *> *)values;

@end

NS_ASSUME_NONNULL_END
