//
//  POIView.h
//  coop_POI
//
//  Created by kenny vm on 20/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AVKit/AVKit.h>
#import "POI.h"

@interface PoiViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) POI *poi;

@end
