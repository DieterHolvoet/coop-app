//
//  MainViewController.m
//  COOP
//
//  Created by ontlener on 27/05/16.
//  Copyright © 2016 Groep 1. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"
#import "MapViewController.h"
#import "Theme.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnLijst;
@property (weak, nonatomic) IBOutlet UIButton *btnKaart;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) ListViewController *listViewController;
@property (strong, nonatomic) MapViewController *mapViewController;

@property (strong, nonatomic) NSArray<Walk*> *walks;
@property (strong, nonatomic) NSArray<Theme*> *themes;

- (IBAction)openListview:(id)sender;
- (IBAction)openMapView:(id)sender;

@end

@implementation MainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Apply styles
    [Styles setHeaderLabelStyles:self.myTitle];
    [Styles setSettingsButtonImage:self.btnSettings];
    [Styles setTabButtonStyles:self.btnKaart];
    [Styles setTabButtonStyles:self.btnLijst];
    
    // Fetch theme list
    [API loadThemeListwithSuccess:^(NSArray<Theme *> *themes) {
        self.themes = themes;
        
    } andFailure:nil];
    
    // Fetch walk list
    [API loadWalkListwithSuccess:^(NSArray<Walk *> *walks) {
        self.walks = walks;
        
        // Empty all arrays
        for(Theme *theme in self.themes) {
            theme.walks = [[NSMutableArray alloc] init];
        }
        
        for(Walk *walk in walks) {
            
            // Add walks to themes
            for(Theme *theme in self.themes) {
                if(walk.theme.theme_id == theme.theme_id) {
                    // NSLog(@"Walk %@ found with theme id %@", walk.walk_id, theme.theme_id);
                    if(theme.walks == nil) {
                        theme.walks = [[NSMutableArray alloc] initWithObjects:walk, nil];
                    } else {
                        [theme.walks addObject:walk];
                    }
                }
            }
            
            // Set finished status of walks
            NSLog(@"Count: %lu", (unsigned long)[[Database getFinishedWalks] count]);
            for(NSNumber* walk_id in [Database getFinishedWalks]) {
                NSLog(@"%d - %d", [walk.walk_id intValue], [walk_id intValue]);
                if([walk.walk_id intValue] == [walk_id intValue]) {
                    walk.isCleared = [NSNumber numberWithBool:YES];
                }
            }
        }
        
        // Send to ListViewController
        self.listViewController.themes = self.themes;
        [self.listViewController.tableOne reloadData];
        
        // Send to MapviewController
        self.mapViewController.walks = self.walks;
        
    } andFailure:nil];
    
    // Initialize storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainPageViewController"];
    self.pageViewController.dataSource = self;
    
    // Initialize viewcontrollers
    self.listViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"ListViewController"];
    self.mapViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"MapViewController"];
    
    [self.pageViewController setViewControllers:@[ self.listViewController ] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    // self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:self.pageViewController];
    [self.containerView addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - IBActions

- (IBAction)openListview:(id)sender {
    [self.pageViewController setViewControllers:@[ self.listViewController ] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (IBAction)openMapView:(id)sender {
    [self.pageViewController setViewControllers:@[ self.mapViewController ] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if([viewController isKindOfClass:MapViewController.class]) {
        return self.listViewController;
        
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if([viewController isKindOfClass:ListViewController.class]) {
        return self.mapViewController;
        
    } else {
        return nil;
    }
}

@end
