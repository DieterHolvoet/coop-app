//
//  RouteViewController.h
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface RouteViewController : UIViewController <QRCodeReaderDelegate>

@property (strong, nonatomic) Walk* walk;
@property (strong, nonatomic) NSArray* stops;

@end
