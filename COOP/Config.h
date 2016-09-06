//
//  Config.h
//  COOP
//
//  Created by ontlener on 23/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

FOUNDATION_EXPORT NSString *const BASE_URL;

+ (NSString*) getPreferredLanguage;
+ (bool) systemLanguageChanged;
+ (bool) interactiveWalkEnabled;

@end
