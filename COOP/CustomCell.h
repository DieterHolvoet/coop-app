//
//  CustomCell.h
//  COOP
//
//  Created by Cédric Brichau on 19/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *wandeling;
@property (nonatomic, weak) IBOutlet UILabel *iconOneInfo;
@property (nonatomic, weak) IBOutlet UILabel *iconTwoInfo;
@property (nonatomic, weak) IBOutlet UILabel *iconThreeInfo;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UIImageView *iconOne;
@property (nonatomic, weak) IBOutlet UIImageView *iconTwo;
@property (nonatomic, weak) IBOutlet UIImageView *iconThree;

@end
