//
//  Helper.m
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (NSString *) getSystemLanguageCode {
    return [[[NSLocale preferredLanguages] objectAtIndex:0] substringToIndex:2];
}

+ (int) getScreenWidth {
    return CGRectGetWidth([[UIScreen mainScreen] bounds]);
}

+ (int) getScreenHeight {
    return CGRectGetHeight([[UIScreen mainScreen] bounds]);
}

+ (void) logAllFontNames {
    for (NSString* family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
            NSLog(@"  %@", name);
        }
    }
}

+ (void) changeViewControllerFrom:(UIViewController*)sender toViewControllerWithIdentifier:(NSString*)identifier withAnimation:(bool)animate {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [sender presentViewController:vc animated:animate completion:nil];
}

@end
