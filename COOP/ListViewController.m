//
//  ViewController.m
//  COOP
//
//  Created by Cédric Brichau on 18/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ListViewController.h"
#import "DetailViewController.h"
#import "MapViewController.h"

#import "Theme.h"
#import "CustomCell.h"

@interface ListViewController ()

@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup TableView
    self.tableOne.dataSource = self;
    self.tableOne.delegate = self;
    
    // Setup NavigationController
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.themes[section].walks == nil) {
        return 0;
    } else {
        return self.themes[section].walks.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.themes == nil) {
        return 0;
    } else {
        return self.themes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell"] ;
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Walk *walk = self.themes[indexPath.section].walks[indexPath.row];
    
    cell.wandeling.text = walk.walk_title;
    cell.iconOneInfo.text = [walk distanceAsString];
    cell.iconTwoInfo.text = [walk durationAsString];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    
    [API loadImageWithURL:[NSURL URLWithString:walk.walk_thumbnail]
               andSuccess:^(UIImage *image) {
                   cell.thumbnailImageView.image = image;
                   
               } andFailure:^(NSError *error) {
                   NSLog(@"Error: %@", error.description);
               }];

    
    if(walk.isCleared) {
        cell.iconThreeInfo.text = NSLocalizedString(@"walk-done", @"Walk is done");
        cell.iconThree.image = [UIImage imageNamed:@"completedIcon"];
        
    } else {
        cell.iconThreeInfo.text = NSLocalizedString(@"walk-not-done", @"Walk is not done");
        cell.iconThree.image = [UIImage imageNamed:@"notCompletedIcon"];
    }
    
    cell.iconOne.image = [UIImage imageNamed:@"timeIcon"];
    cell.iconTwo.image = [UIImage imageNamed:@"distanceIcon"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(self.themes == nil) {
        return @"";
    } else {
        return [self.themes[section].theme_name uppercaseString];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    [self performSegueWithIdentifier:@"toDetail" sender:tableView];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 30;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toDetail"]) {
        DetailViewController *vc = [segue destinationViewController];
        vc.walk = self.themes[self.currentIndexPath.section].walks[self.currentIndexPath.row];
        
    }
}

@end
