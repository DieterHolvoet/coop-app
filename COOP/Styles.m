//
//  Styles.m
//  COOP
//
//  Created by Cédric Brichau on 23/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import "Styles.h"
#import <UIKit/UIKit.h>

@implementation Styles

+ (void) setButtonStyle:(UIButton *)button {
    button.layer.cornerRadius = 10;
    button.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    [button setTitleColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0] forState:UIControlStateNormal];
}

+ (void) setButtonStyleWithPadding:(UIButton *)button {
    [Styles setButtonStyle:button];
    button.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 20.0f, 5.0f, 20.0f);
}

+ (void) setPageControlAppearance {
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
}

+ (void) setTableviewLabelAppearance {
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setTextColor:[UIColor lightGrayColor]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setFont:[UIFont fontWithName:@"MissionGothic-Regular" size:14.0]];
}

+ (void) setSettingsButtonImage:(UIButton*)button {
    [button setImage:[UIImage imageNamed:@"settingsIconWhite"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
}

+ (void) setBackButtonImage:(UIButton*)button {
    [button setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
}

+ (void) setTabButtonStyles:(UIButton*)button {
    button.layer.cornerRadius = button.frame.size.height / 2;
}

+ (void) setHeaderLabelStyles:(UILabel*)label {
    label.layer.borderWidth = 2.0;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.cornerRadius = 5;
}

+ (NSNumberFormatter*) getFloatFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingIncrement = [NSNumber numberWithDouble:0.01];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return formatter;
}

@end
