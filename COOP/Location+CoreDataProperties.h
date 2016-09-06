//
//  Location+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *location_city;
@property (nullable, nonatomic, retain) NSNumber *location_house_number;
@property (nullable, nonatomic, retain) NSNumber *location_id;
@property (nullable, nonatomic, retain) NSNumber *location_lat;
@property (nullable, nonatomic, retain) NSNumber *location_lon;
@property (nullable, nonatomic, retain) NSNumber *location_postal_code;
@property (nullable, nonatomic, retain) NSString *location_street;

@end

NS_ASSUME_NONNULL_END
