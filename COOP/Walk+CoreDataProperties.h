//
//  Walk+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 25/05/16.
//  Copyright © 2016 Groep 1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Walk.h"

NS_ASSUME_NONNULL_BEGIN

@interface Walk (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *creation_date;
@property (nullable, nonatomic, retain) NSNumber *isCleared;
@property (nullable, nonatomic, retain) NSNumber *progress;
@property (nullable, nonatomic, retain) NSString *walk_description;
@property (nullable, nonatomic, retain) NSNumber *walk_distance;
@property (nullable, nonatomic, retain) NSNumber *walk_duration;
@property (nullable, nonatomic, retain) NSNumber *walk_id;
@property (nullable, nonatomic, retain) NSString *walk_title;
@property (nullable, nonatomic, retain) NSString *walk_thumbnail;
@property (nullable, nonatomic, retain) AverageLocation *average_location;
@property (nullable, nonatomic, retain) NSSet<POI *> *pois;
@property (nullable, nonatomic, retain) Theme *theme;
@property (nullable, nonatomic, retain) NSSet<Waypoint *> *waypoints;

@end

@interface Walk (CoreDataGeneratedAccessors)

- (void)addPoisObject:(POI *)value;
- (void)removePoisObject:(POI *)value;
- (void)addPois:(NSSet<POI *> *)values;
- (void)removePois:(NSSet<POI *> *)values;

- (void)addWaypointsObject:(Waypoint *)value;
- (void)removeWaypointsObject:(Waypoint *)value;
- (void)addWaypoints:(NSSet<Waypoint *> *)values;
- (void)removeWaypoints:(NSSet<Waypoint *> *)values;

@end

NS_ASSUME_NONNULL_END
