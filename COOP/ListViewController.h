//
//  ViewController.h
//  COOP
//
//  Created by Cédric Brichau on 18/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableOne;
@property (strong, nonatomic) NSArray<Theme*> *themes;

@end
