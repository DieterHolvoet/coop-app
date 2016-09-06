//
//  BlockTypes.h
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Walk.h"
#ifndef BlockTypes_h
#define BlockTypes_h

typedef void (^ WalkSuccessBlock) (Walk *walk);
typedef void (^ WalkListSuccessBlock) (NSArray<Walk*> *walks);
typedef void (^ ThemeListSuccessBlock) (NSArray<Theme*> *themes);
typedef void (^ ImageSuccessBlock) (UIImage *image);
typedef void (^ FailureBlock) (NSError *error);

#endif /* BlockTypes_h */
