//
//  TutorialViewController.h
//  tutorial
//
//  Created by kenny vm on 23/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialPageContentViewController.h"

@interface TutorialViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *tekst;
@property (strong, nonatomic) NSArray *pageImages;

@end
