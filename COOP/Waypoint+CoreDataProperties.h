//
//  Waypoint+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Waypoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface Waypoint (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *stop_sequence;
@property (nullable, nonatomic, retain) NSString *waypoint_description;
@property (nullable, nonatomic, retain) NSString *waypoint_id;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) NSSet<Media *> *media;

@end

@interface Waypoint (CoreDataGeneratedAccessors)

- (void)addMediaObject:(Media *)value;
- (void)removeMediaObject:(Media *)value;
- (void)addMedia:(NSSet<Media *> *)values;
- (void)removeMedia:(NSSet<Media *> *)values;

@end

NS_ASSUME_NONNULL_END
