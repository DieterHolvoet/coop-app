//
//  ThemeList+CoreDataProperties.h
//  COOP
//
//  Created by ontlener on 23/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ThemeList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemeList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<Theme *> *themes;

@end

@interface ThemeList (CoreDataGeneratedAccessors)

- (void)addThemesObject:(Theme *)value;
- (void)removeThemesObject:(Theme *)value;
- (void)addThemes:(NSSet<Theme *> *)values;
- (void)removeThemes:(NSSet<Theme *> *)values;

@end

NS_ASSUME_NONNULL_END
