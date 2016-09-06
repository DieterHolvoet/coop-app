//
//  API.m
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "API.h"
#import "Media.h"
#import "POI.h"
#import "Waypoint.h"
#import "NSString+HTML.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation API

#pragma mark - Public methods

+ (void) loadWalkWithID: (int)id andSuccess:(WalkSuccessBlock)success andFailure:(FailureBlock)failure andActivityIndicator:(UIActivityIndicatorView *)indicator {
    Walk *walk = [Database fetchWalkFromContextWithID:id];
    
    bool hasIndicator = (indicator != nil);
    bool hasSuccessBlock = (success != nil);
    bool hasFailureBlock = (failure != nil);
    
    if(hasIndicator) [indicator startAnimating];
    //walk == nil || walk.pois.count == 0 || walk.waypoints.count == 0
    if(true) {
        NSLog(@"Walk with ID %d not found in database. Fetching from the API...", id);
        
        [[RKObjectManager sharedManager]
         getObjectsAtPath:[NSString stringWithFormat:@"/~dieter.holvoet/IMAW/api/walks/%d/", id ]
         parameters:@{ @"lang": [Helper getSystemLanguageCode], @"grouped": @"0" }
         success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
             
             // Fetch data from Core Data
             Walk *walk = [Database fetchWalkFromContextWithID:id];
             
             walk.walk_title = [walk.walk_title stringByDecodingHTMLEntities];
             walk.walk_description = [walk.walk_description stringByDecodingHTMLEntities];
             
             // Cache all images
             for(int i = 0; i < walk.stops.count; i++) {
                 NSSet* media = nil;
                 
                 if([walk.stops[i] isKindOfClass:POI.class]) {
                     POI *poi = walk.stops[i];
                     media = poi.media;
                     poi.poi_title = [poi.poi_title stringByDecodingHTMLEntities];
                     poi.poi_description = [poi.poi_description stringByDecodingHTMLEntities];
                     
                 } else if([walk.stops[i] isKindOfClass:Waypoint.class]) {
                     Waypoint *waypoint = walk.stops[i];
                     media = waypoint.media;
                     waypoint.waypoint_description = [waypoint.waypoint_description stringByDecodingHTMLEntities];
                 }
                 
                 for(Media *image in media) {
                     [API loadImageWithURL:[NSURL URLWithString:image.media_url] andSuccess:nil andFailure:nil];
                 }
             }
             
             // [API logWalk:walk];
             if(hasIndicator) [indicator stopAnimating];
             if(hasSuccessBlock) success(walk);
         }
         failure: ^(RKObjectRequestOperation *operation, NSError *error) {
             if(hasIndicator) [indicator stopAnimating];
             if(hasFailureBlock) failure(error);
         }];

    } else {
        // [API logWalk:walk];
        if(hasIndicator) [indicator stopAnimating];
        if(hasSuccessBlock) success(walk);
    }
}

+ (void) loadImageWithURL:(NSURL*)url andSuccess:(ImageSuccessBlock)success andFailure:(FailureBlock)failure {
    
    bool hasSuccessBlock = (success != nil);
    bool hasFailureBlock = (failure != nil);
    
    // Setup image downloader & cache
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    SDImageCache *imageCache = [[SDImageCache alloc] initWithNamespace:@"myNamespace"];
    
    // Fetch image from disk
    [imageCache queryDiskCacheForKey:[url absoluteString] done:^(UIImage *image, SDImageCacheType type) {
        if(image == nil) {
            [downloader downloadImageWithURL:url
                                     options:0
                                    progress:nil
                                   completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                       if (image && finished) {
                                           [[SDImageCache sharedImageCache] storeImage:image forKey:[url absoluteString]];
                                           
                                           if(hasSuccessBlock) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   success(image);
                                               });
                                           }
                                           
                                       } else {
                                           if(hasFailureBlock) failure(error);
                                       }
                                   }];
            
        } else {
            if(hasSuccessBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(image);
                });
            }
        }
    }];
}

+ (void) loadWalkListwithSuccess:(WalkListSuccessBlock)success andFailure:(FailureBlock)failure {
    
    bool hasSuccessBlock = (success != nil);
    bool hasFailureBlock = (failure != nil);
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:@"/~dieter.holvoet/IMAW/api/walks/"
     parameters:@{ @"lang": [Helper getSystemLanguageCode] }
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray *walks = [Database fetchWalkListFromContext];
         
         for(Walk *walk in walks) {
             walk.walk_title = [walk.walk_title stringByDecodingHTMLEntities];
             walk.walk_description = [walk.walk_description stringByDecodingHTMLEntities];
         }
         
         if(hasSuccessBlock) success(walks);
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         if(hasFailureBlock) failure(error);
     }];
}

+ (void) loadThemeListwithSuccess:(ThemeListSuccessBlock)success andFailure:(FailureBlock)failure {
    
    bool hasSuccessBlock = (success != nil);
    bool hasFailureBlock = (failure != nil);
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:@"/~dieter.holvoet/IMAW/api/themes/"
     parameters:@{ @"lang": [Helper getSystemLanguageCode] }
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray *themes = [Database fetchThemeListFromContext];
         if(hasSuccessBlock) success(themes);
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         if(hasFailureBlock) failure(error);
     }];
}

#pragma mark - Private methods

+ (void) logWalk:(Walk*)walk {
    NSLog(@"Walk with ID %@ found in database.", walk.walk_id);
    NSLog(@"Title: %@", walk.walk_title);
    NSLog(@"Description: %@", walk.walk_description);
    NSLog(@"Amount of stops: %lu", (unsigned long)walk.stops.count);
}

@end
