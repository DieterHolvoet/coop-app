//
//  Parser.h
//  COOP
//
//  Created by ontlener on 22/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XNGMarkdownParser.h"

@interface Parser : NSObject

+ (XNGMarkdownParser *)paragraphParser;
+ (XNGMarkdownParser *)paragraphParserCenter;
+ (XNGMarkdownParser *)headerParser;

@end
