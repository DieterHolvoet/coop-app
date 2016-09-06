//
//  DatabaseManager.m
//  COOP
//
//  Created by ontlener on 23/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "DatabaseManager.h"
#import <CoreData/CoreData.h>

@interface DatabaseManager ()

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) RKObjectManager *objectManager;
@property (strong, nonatomic) RKManagedObjectStore *managedObjectStore;

- (void)setupManagedObjectContext;

@end


@implementation DatabaseManager

static DatabaseManager *databaseManager;

+ (DatabaseManager *)sharedManager {
    if (!databaseManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            databaseManager = [[DatabaseManager alloc] init];
        });
    }
    
    return databaseManager;
}

#pragma mark - CoreData

- (id) init {
    self = [super init];
    
    if (self) {
        [self setupManagedObjectContext];
        [self setupMappings];
    }
    
    return self;
}

- (void) setupManagedObjectContext {
    
    // Initialize RestKit
    self.objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL]];
    
    // Initialize managed object model from bundle
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Initialize managed object store
    self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:self.managedObjectModel];
    self.objectManager.managedObjectStore = self.managedObjectStore;
    
    // Complete Core Data stack initialization
    [self.managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"COOP.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [self.managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [self.managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    self.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:self.managedObjectStore.persistentStoreManagedObjectContext];
}

- (void) resetPersistentStores {
    [[RKManagedObjectStore defaultStore] resetPersistentStores:nil];
}

#pragma mark - RestKit

-(void) setupMappings {
    
    // AverageLocation
    RKEntityMapping *avgLocationMapping = [RKEntityMapping mappingForEntityForName:@"AverageLocation" inManagedObjectStore:self.managedObjectStore];
    avgLocationMapping.identificationAttributes = @[@"lat", @"lon"];
    [avgLocationMapping addAttributeMappingsFromArray:@[@"lat", @"lon"]];
    
    
    // Location
    RKEntityMapping *locationMapping = [RKEntityMapping mappingForEntityForName:@"Location" inManagedObjectStore:self.managedObjectStore];
    locationMapping.identificationAttributes = @[ @"location_id" ];
    [locationMapping addAttributeMappingsFromArray:@[@"location_id", @"location_lat", @"location_lon", @"location_house_number", @"location_postal_code", @"location_street", @"location_city"]];
    
    
    // Media
    RKEntityMapping *waypointMediaMapping = [RKEntityMapping mappingForEntityForName:@"Media" inManagedObjectStore:self.managedObjectStore];
    waypointMediaMapping.identificationAttributes = @[ @"media_id" ];
    [waypointMediaMapping addAttributeMappingsFromArray:@[ @"media_id", @"media_url", @"media_type_name" ]];
    
    RKEntityMapping *poiMediaMapping = [RKEntityMapping mappingForEntityForName:@"Media" inManagedObjectStore:self.managedObjectStore];
    poiMediaMapping.identificationAttributes = @[ @"media_id" ];
    [poiMediaMapping addAttributeMappingsFromArray:@[ @"media_id", @"media_title", @"media_description", @"media_url", @"media_type_name" ]];
    
    // POI
    RKEntityMapping *poiMapping = [RKEntityMapping mappingForEntityForName:@"POI" inManagedObjectStore:self.managedObjectStore];
    poiMapping.identificationAttributes = @[ @"poi_id" ];
    [poiMapping addAttributeMappingsFromArray:@[@"poi_id", @"poi_unlock_code", @"poi_title", @"poi_description", @"stop_sequence"]];
    
    [poiMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location"
                                                                               toKeyPath:@"location"
                                                                             withMapping:locationMapping]];
    
    [poiMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media"
                                                                               toKeyPath:@"media"
                                                                             withMapping:poiMediaMapping]];
    
    
    // Theme
    RKEntityMapping *themeMapping = [RKEntityMapping mappingForEntityForName:@"Theme" inManagedObjectStore:self.managedObjectStore];
    themeMapping.identificationAttributes = @[ @"theme_id" ];
    [themeMapping addAttributeMappingsFromArray:@[@"theme_id", @"theme_color", @"theme_name"]];
    
    // ThemeList
    RKEntityMapping *themeListMapping = [RKEntityMapping mappingForEntityForName:@"ThemeList" inManagedObjectStore:self.managedObjectStore];
    [themeListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"themes"
                                                                                    toKeyPath:@"themes"
                                                                                  withMapping:themeMapping]];
    
    [self.objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:themeListMapping
                                                                                           method:RKRequestMethodGET
                                                                                      pathPattern:@"/~dieter.holvoet/IMAW/api/themes/"
                                                                                          keyPath:nil
                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                               ]];

    
    
    // Waypoint
    RKEntityMapping *waypointMapping = [RKEntityMapping mappingForEntityForName:@"Waypoint" inManagedObjectStore:self.managedObjectStore];
    waypointMapping.identificationAttributes = @[ @"waypoint_id" ];
    [waypointMapping addAttributeMappingsFromArray:@[@"waypoint_id", @"waypoint_description", @"stop_sequence"]];
    
    [waypointMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location"
                                                                                    toKeyPath:@"location"
                                                                                  withMapping:locationMapping]];
    
    [waypointMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media"
                                                                                    toKeyPath:@"media"
                                                                                  withMapping:waypointMediaMapping]];
    
    
    // Walk
    RKEntityMapping *walkMapping = [RKEntityMapping mappingForEntityForName:@"Walk" inManagedObjectStore:self.managedObjectStore];
    walkMapping.identificationAttributes = @[ @"walk_id" ];
    [walkMapping addAttributeMappingsFromArray:@[@"walk_id", @"walk_distance", @"walk_duration", @"walk_description", @"walk_title", @"walk_thumbnail", @"creation_date"]];
    
    [walkMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"walk_average_location"
                                                                                toKeyPath:@"average_location"
                                                                              withMapping:avgLocationMapping]];
    
    [walkMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pois"
                                                                                toKeyPath:@"pois"
                                                                              withMapping:poiMapping]];
    
    [walkMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"theme"
                                                                                toKeyPath:@"theme"
                                                                              withMapping:themeMapping]];
    
    [walkMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"waypoints"
                                                                                toKeyPath:@"waypoints"
                                                                              withMapping:waypointMapping]];
    
    [self.objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:walkMapping
                                                                                           method:RKRequestMethodGET
                                                                                      pathPattern:@"/~dieter.holvoet/IMAW/api/walks/:id/"
                                                                                          keyPath:nil
                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                               ]];
    
    // WalkList
    RKEntityMapping *walkListMapping = [RKEntityMapping mappingForEntityForName:@"WalkList" inManagedObjectStore:self.managedObjectStore];
    [walkListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"walks"
                                                                                    toKeyPath:@"walks"
                                                                                  withMapping:walkMapping]];
    
    [self.objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:walkListMapping
                                                                                           method:RKRequestMethodGET
                                                                                      pathPattern:@"/~dieter.holvoet/IMAW/api/walks/"
                                                                                          keyPath:nil
                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                               ]];
}


@end
