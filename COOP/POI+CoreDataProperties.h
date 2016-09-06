//
//  POI+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "POI.h"

NS_ASSUME_NONNULL_BEGIN

@interface POI (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *poi_description;
@property (nullable, nonatomic, retain) NSNumber *poi_id;
@property (nullable, nonatomic, retain) NSString *poi_title;
@property (nullable, nonatomic, retain) NSString *poi_unlock_code;
@property (nullable, nonatomic, retain) NSNumber *stop_sequence;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) NSSet<Media *> *media;

@end

@interface POI (CoreDataGeneratedAccessors)

- (void)addMediaObject:(Media *)value;
- (void)removeMediaObject:(Media *)value;
- (void)addMedia:(NSSet<Media *> *)values;
- (void)removeMedia:(NSSet<Media *> *)values;

@end

NS_ASSUME_NONNULL_END
