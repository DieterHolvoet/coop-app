//
//  SettingsController.m
//  Coop settings
//
//  Created by kenny vm on 20/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *groupView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UISwitch *switch1;
@property (nonatomic, strong) UISwitch *switch2;
@property (nonatomic, strong) UILabel *labelUitleg;

@end

@implementation SettingsController

- (void)toggleInteractiveWalk:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"interactiveWalkEnabled"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *superview = self.view;
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setHidesBackButton:NO animated:NO];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
    
    // Add first header
    self.label = [self addHeaderItemWithTitle:NSLocalizedString(@"interactivity", @"Interactivity")];
    
    // Add settings item
    self.view1 = [self addSettingsItemWithExistingHeader:self.label
                             andDescription:NSLocalizedString(@"settings-interactive-walk-description", @"Interactive walk")
                                   andTitle:NSLocalizedString(@"settings-interactive-walk", @"Interactive walk")
                             andToggleState:[Config interactiveWalkEnabled]];
    
    // Add second settings item
    [self addSecondSettingsItem];
    
    // Add line below header
    [self addLineBelowHeader];
}

- (UILabel*) addHeaderItemWithTitle:(NSString*)title {
    
    // Add item
    UILabel *item = [[UILabel alloc] init];
    item.translatesAutoresizingMaskIntoConstraints = NO;
    item.numberOfLines = 0;
    item.text = title;
    
    // Add items to superview
    UIView *superview = self.view;
    [superview addSubview:item];
    
    // Add item constraints
    NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint
                                              constraintWithItem:item attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:superview
                                              attribute:NSLayoutAttributeTop multiplier:1.0 constant:70.0f];
    NSLayoutConstraint *labelBottomConstraint = [NSLayoutConstraint
                                                 constraintWithItem:item attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:item
                                                 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint
                                               constraintWithItem:item attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                               NSLayoutAttributeLeft multiplier:1.0 constant:15.0f];
    NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint
                                                constraintWithItem:item attribute:NSLayoutAttributeRight
                                                relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                NSLayoutAttributeRight multiplier:1.0 constant:-20.0f];
    [superview addConstraints:@[labelBottomConstraint ,
                                labelLeftConstraint, labelRightConstraint,
                                labelTopConstraint]];
    
    return item;
}

- (void) addLineBelowHeader {
    UIView *superview = self.view;
    CGRect  viewRect3 = CGRectMake(10, 10, 20, 20);
    self.view3 = [[UIView alloc] initWithFrame:viewRect3];
    self.view3.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    self.view3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.view3];
    // self.view1.center = CGPointMake(superview.frame.size.width  / 2, superview.frame.size.height / 2);
    
    NSLayoutConstraint *view3TopConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.view3
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0 constant:95.0f];
    NSLayoutConstraint *view3HeightConstraint = [NSLayoutConstraint
                                                 constraintWithItem:self.view3
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.label
                                                 attribute:NSLayoutAttributeHeight
                                                 multiplier:0.1 constant:0.0f];
    NSLayoutConstraint *view3LeadingConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.view3
                                                  attribute:NSLayoutAttributeLeading
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:superview
                                                  attribute:NSLayoutAttributeLeading
                                                  multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *view3TrailingConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.view3
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:superview
                                                   attribute:NSLayoutAttributeTrailing
                                                   multiplier:1.0 constant:0.0f];
    [superview addConstraints:@[view3HeightConstraint ,
                                view3LeadingConstraint, view3TrailingConstraint,
                                view3TopConstraint]];

}

-(UIView*) addSettingsItemWithExistingHeader:(UIView*)header andDescription:(NSString*)descriptionText andTitle:(NSString*)titleText andToggleState:(bool)toggleState {
    
    // Add settings item
    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    item.backgroundColor = [UIColor whiteColor];
    item.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Add description label
    UILabel *description = [[UILabel alloc] init];
    description.translatesAutoresizingMaskIntoConstraints = NO;
    description.numberOfLines = 0;
    description.text = descriptionText;
    [description setFont:[UIFont systemFontOfSize:11]];
    
    // Add title button
    UIButton* titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    titleButton.translatesAutoresizingMaskIntoConstraints = NO;
    [titleButton setTitle:titleText forState:UIControlStateNormal];
    
    // Add switch
    UISwitch *toggle = [[UISwitch alloc] initWithFrame: CGRectZero];
    toggle.translatesAutoresizingMaskIntoConstraints = NO;
    toggle.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [toggle setOnTintColor:[UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1]];
    [toggle setOn:toggleState];
    [toggle addTarget:self action:@selector(toggleInteractiveWalk:) forControlEvents:UIControlEventValueChanged];

    
    // Add items to superview
    UIView *superview = self.view;
    [superview addSubview:item];
    [item addSubview:description];
    [item addSubview:titleButton];
    [item addSubview:toggle];
    
    // Add settings item constraints
    NSLayoutConstraint *view1TopConstraint = [NSLayoutConstraint
                                              constraintWithItem:item
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0 constant:95.0f]; // de hoogte
    NSLayoutConstraint *view1HeightConstraint = [NSLayoutConstraint
                                                 constraintWithItem:item
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:header
                                                 attribute:NSLayoutAttributeHeight
                                                 multiplier:1.0 constant:63.0f]; // hoe ver van de top
    NSLayoutConstraint *view1LeadingConstraint = [NSLayoutConstraint
                                                  constraintWithItem:item
                                                  attribute:NSLayoutAttributeLeading
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:superview
                                                  attribute:NSLayoutAttributeLeading
                                                  multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *view1TrailingConstraint = [NSLayoutConstraint
                                                   constraintWithItem:item
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:superview
                                                   attribute:NSLayoutAttributeTrailing
                                                   multiplier:1.0 constant:0.0f];
    [superview addConstraints:@[view1HeightConstraint ,
                                view1LeadingConstraint, view1TrailingConstraint,
                                view1TopConstraint]];
    
    
    // Add button constraints
    NSLayoutConstraint *button1XConstraint = [NSLayoutConstraint
                                              constraintWithItem:titleButton
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:item
                                              attribute:NSLayoutAttributeLeft
                                              multiplier:1.0f constant:25.0f];
    
    NSLayoutConstraint *button1YConstraint = [NSLayoutConstraint
                                              constraintWithItem:titleButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:item
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:0.55f constant:0.0f];
    
    [item addConstraints:@[ button1XConstraint,
                                  button1YConstraint]];
    
    
    // Add switch constraints
    NSLayoutConstraint *switch1XConstraint = [NSLayoutConstraint
                                              constraintWithItem:toggle
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                              toItem:item
                                              attribute:NSLayoutAttributeRight
                                              multiplier:0.95 constant:0.0f];
    
    NSLayoutConstraint *switch1YConstraint = [NSLayoutConstraint
                                              constraintWithItem:toggle
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:item
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1.0f constant:0.0f];
    
    [item addConstraints:@[ switch1XConstraint,
                                  switch1YConstraint]];
    
    // Add description label constraints
    NSLayoutConstraint *labelUitlegTopConstraint = [NSLayoutConstraint
                                                    constraintWithItem:description attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:titleButton
                                                    attribute:NSLayoutAttributeTop multiplier:1.0 constant:25.0f];
    
    NSLayoutConstraint *labelUitlegBottomConstraint = [NSLayoutConstraint
                                                       constraintWithItem:description attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:description
                                                       attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0f];
    
    NSLayoutConstraint *labelUitlegLeftConstraint = [NSLayoutConstraint
                                                     constraintWithItem:description attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual toItem:item attribute:
                                                     NSLayoutAttributeLeft multiplier:1.0 constant:25.0f];
    
    NSLayoutConstraint *labelUitlegRightConstraint = [NSLayoutConstraint
                                                      constraintWithItem:description attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual toItem:item attribute:
                                                      NSLayoutAttributeRight multiplier:1.0 constant:-85.0f];
    
    [item addConstraints:@[labelUitlegBottomConstraint ,
                                 labelUitlegLeftConstraint, labelUitlegRightConstraint,
                                 labelUitlegTopConstraint]];
    
    return item;
}

-(void)addSecondSettingsItem {
    UIView *superview = self.view;
    
    //10. Add view2
    CGRect  viewRect2 = CGRectMake(10, 10, 20, 20);
    self.view2 = [[UIView alloc] initWithFrame:viewRect2];
    self.view2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    self.view2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.view2];
    // self.view1.center = CGPointMake(superview.frame.size.width  / 2, superview.frame.size.height / 2);
    
    NSLayoutConstraint *view2TopConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.view2
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0 constant:180.0f];
    NSLayoutConstraint *view2HeightConstraint = [NSLayoutConstraint
                                                 constraintWithItem:self.view2
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.label
                                                 attribute:NSLayoutAttributeHeight
                                                 multiplier:1.0 constant:50.0f];
    NSLayoutConstraint *view2LeadingConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.view2
                                                  attribute:NSLayoutAttributeLeading
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:superview
                                                  attribute:NSLayoutAttributeLeading
                                                  multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *view2TrailingConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.view2
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:superview
                                                   attribute:NSLayoutAttributeTrailing
                                                   multiplier:1.0 constant:0.0f];
    [superview addConstraints:@[view2HeightConstraint ,
                                view2LeadingConstraint, view2TrailingConstraint,
                                view2TopConstraint]];
    
    /*1. Add button2 */
    self.button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button2 setTitle:NSLocalizedString(@"settings-notifications", @"Notifications") forState:UIControlStateNormal];
    [self.view2 addSubview:self.button2];
    
    NSLayoutConstraint *button2XConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.button2
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                              toItem:self.view2
                                              attribute:NSLayoutAttributeLeft
                                              multiplier:1.0 constant:25.0f];
    
    NSLayoutConstraint *button2YConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.button2
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view2
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1.0f constant:0.0f];
    
    [self.view2 addConstraints:@[ button2XConstraint,
                                  button2YConstraint]];
    
    
    /*1. Add switch2 */
    self.switch2 = [[UISwitch alloc] initWithFrame: CGRectZero];
    self.switch2.translatesAutoresizingMaskIntoConstraints = NO;
    self.switch2.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [self.switch2 setOnTintColor:[UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1]];
    [self.view2 addSubview:self.switch2];
    
    NSLayoutConstraint *switch2XConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.switch2
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                              toItem:self.view2
                                              attribute:NSLayoutAttributeRight
                                              multiplier:0.95 constant:0.0f];
    
    NSLayoutConstraint *switch2YConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.switch2
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view2
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1.0f constant:0.0f];
    
    [self.view2 addConstraints:@[ switch2XConstraint,
                                  switch2YConstraint]];
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // Hide the navigationbar again
        self.navigationController.navigationBarHidden = YES;
    }
    [super viewWillDisappear:animated];
}

@end
