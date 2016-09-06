//
//  Media+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Media.h"

NS_ASSUME_NONNULL_BEGIN

@interface Media (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *media_description;
@property (nullable, nonatomic, retain) NSNumber *media_id;
@property (nullable, nonatomic, retain) NSString *media_title;
@property (nullable, nonatomic, retain) NSString *media_type_name;
@property (nullable, nonatomic, retain) NSString *media_url;

@end

NS_ASSUME_NONNULL_END
