//
//  Helper.h
//  COOP
//
//  Created by ontlener on 19/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSString *) getSystemLanguageCode;
+ (int) getScreenWidth;
+ (int) getScreenHeight;
+ (void) logAllFontNames;
+ (void) changeViewControllerFrom:(UIViewController*)sender toViewControllerWithIdentifier:(NSString*)identifier withAnimation:(bool)animate;

@end
