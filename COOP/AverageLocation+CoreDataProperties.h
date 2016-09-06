//
//  AverageLocation+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AverageLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface AverageLocation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *lat;
@property (nullable, nonatomic, retain) NSNumber *lon;

@end

NS_ASSUME_NONNULL_END
