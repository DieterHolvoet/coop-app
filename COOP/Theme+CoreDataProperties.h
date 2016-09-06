//
//  Theme+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Theme.h"

NS_ASSUME_NONNULL_BEGIN

@interface Theme (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *theme_color;
@property (nullable, nonatomic, retain) NSNumber *theme_id;
@property (nullable, nonatomic, retain) NSString *theme_name;

@end

NS_ASSUME_NONNULL_END
