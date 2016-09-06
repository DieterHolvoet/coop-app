//
//  Theme.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Theme : NSManagedObject

@property (strong, nonatomic) NSMutableArray *walks;
@property (strong, nonatomic) NSString *identifier;

@end

NS_ASSUME_NONNULL_END

#import "Theme+CoreDataProperties.h"
