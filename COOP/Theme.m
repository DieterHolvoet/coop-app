//
//  Theme.m
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Theme.h"

@implementation Theme

@synthesize walks;
@synthesize identifier;

- (NSString*) identifier {
    return [NSString stringWithFormat:@"theme_%@", self.theme_id];
}

@end
