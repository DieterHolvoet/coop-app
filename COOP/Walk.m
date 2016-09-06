//
//  Walk.m
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Walk.h"
#import "AverageLocation.h"
#import "POI.h"
#import "Theme.h"
#import "Waypoint.h"

@interface Walk ()

@property (strong, nonatomic) NSNumberFormatter *floatFormatter;

@end

@implementation Walk

@synthesize stops;
@synthesize floatFormatter;

- (NSNumberFormatter*) floatFormatter {
    if(floatFormatter == nil) {
        floatFormatter = [Styles getFloatFormatter];
    }
    
    return floatFormatter;
}

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake([self.average_location.lat doubleValue],
                                     [self.average_location.lon doubleValue]);
}

- (NSString*) title {
    return self.walk_title;
}

- (NSString*) subtitle {
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.theme.theme_name, [self durationAsString], [self distanceAsString]];
}

- (NSString*) distanceAsString {
    return [NSString stringWithFormat:@"%@ km",
    [self.floatFormatter stringFromNumber:@([self.walk_distance floatValue] / 1000.0f)]];
}

- (NSString*) durationAsString {
    return [NSString stringWithFormat:@"%@ min", self.walk_duration];
}

@end
