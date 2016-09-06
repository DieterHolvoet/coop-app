//
//  Styles.h
//  COOP
//
//  Created by Cédric Brichau on 23/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Styles : NSObject

+ (void) setButtonStyle:(UIButton *)button;
+ (void) setButtonStyleWithPadding:(UIButton *)button;
+ (void) setPageControlAppearance;
+ (void) setTableviewLabelAppearance;
+ (void) setSettingsButtonImage:(UIButton*)button;
+ (void) setBackButtonImage:(UIButton*)button;
+ (void) setHeaderLabelStyles:(UILabel*)label;
+ (void) setTabButtonStyles:(UIButton*)button;
+ (NSNumberFormatter*) getFloatFormatter;

@end
