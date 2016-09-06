//
//  TutorialViewController.m
//  tutorial
//
//  Created by kenny vm on 23/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import "TutorialViewController.h"
#import "ListViewController.h"
#import "TutorialPageContentViewController.h"
#import "Styles.h"

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *background;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Only show once
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]) {
        NSLog(@"Tutorial was seen before, proceeding to first screen...");
        [Helper changeViewControllerFrom:self toViewControllerWithIdentifier:@"NavigationController" withAnimation:NO];
        
    } else {
        NSLog(@"First launch, setting up tutorial...");
        [self setupTutorial];
    }
}

- (void) setupTutorial {
    
    // Create the data model
    _pageTitles = @[@"Welkom", @"", @"", @""];
    _pageImages = @[@"logo.png", @"logo.png", @"logo.png", @"logo.png"];
    _tekst = @[@"Met de Coop app kan je leuke en leerijke wandelingen maken.",
               @"Je kan uit de lijst een wandeling kiezen. Als je een leuke wandeling hebt gevonden druk je op downloaden en daarna op starten om de wandeling te beginnen.",
               @"Heb plezier en probeer alle QR-codes te verzamelen."];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    // Open first page
    TutorialPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (TutorialPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.tekst count] == 0) || (index >= [self.tekst count])) {
        return nil;
    }
    
    // Create a new view controller
    TutorialPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    // Pass suitable data
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.tekstText = self.tekst[index];
    pageContentViewController.buttonText = NSLocalizedString(@"tutorial-start-app", @"Skip button on last tutorial screen");
    pageContentViewController.pageIndex = index;
    pageContentViewController.showSkipButton = ((index + 1) == [self.tekst count]);
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((TutorialPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((TutorialPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.tekst count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.tekst count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
