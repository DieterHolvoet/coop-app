//
//  CustomCell.m
//  COOP
//
//  Created by Cédric Brichau on 19/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize wandeling = _wandeling;
@synthesize iconOneInfo = _iconOneInfo;
@synthesize iconTwoInfo = _iconTwoInfo;
@synthesize iconThreeInfo = _iconThreeInfo;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize iconOne = _iconOne;
@synthesize iconTwo = _iconTwo;
@synthesize iconThree = _iconThree;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
