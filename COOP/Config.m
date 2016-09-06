//
//  Config.m
//  COOP
//
//  Created by ontlener on 23/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Config.h"

@interface Config ()

@property (strong, nonatomic) NSString *lastSystemLanguage;

@end

@implementation Config

NSString* const BASE_URL = @"http://iwtsl.ehb.be";

+ (NSString*) getPreferredLanguage {
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"preferredLanguage"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[Helper getSystemLanguageCode] forKey:@"preferredLanguage"];
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"preferredLanguage"];
}

+ (bool) interactiveWalkEnabled {
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"interactiveWalkEnabled"] == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"preferredLanguage"];
    }
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"interactiveWalkEnabled"];
}

+ (bool) systemLanguageChanged {
    NSString *last = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSystemLanguage"];
    NSString *current = [Helper getSystemLanguageCode];
    
    if(![last isEqualToString:current]) {
        [[NSUserDefaults standardUserDefaults] setObject:[Helper getSystemLanguageCode] forKey:@"lastSystemLanguage"];
    }
    
    return ![last isEqualToString:current];
}

@end
