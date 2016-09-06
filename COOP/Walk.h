//
//  Walk.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import Mapbox;

@class AverageLocation, POI, Theme, Waypoint;

NS_ASSUME_NONNULL_BEGIN

@interface Walk : NSManagedObject <MGLAnnotation>

@property (strong, nonatomic) NSArray *stops;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;
@property (nonatomic, readonly, copy, nullable) NSString *title;

- (NSString*) distanceAsString;
- (NSString*) durationAsString;

@end

NS_ASSUME_NONNULL_END

#import "Walk+CoreDataProperties.h"
