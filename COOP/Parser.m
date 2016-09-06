//
//  Parser.m
//  COOP
//
//  Created by ontlener on 22/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "Parser.h"
#import "Helper.h"
#import "XNGMarkdownParser.h"

@implementation Parser

+ (XNGMarkdownParser *)paragraphParser {
    static dispatch_once_t onceToken;
    static XNGMarkdownParser *parser;
    dispatch_once(&onceToken, ^{
        parser = [[XNGMarkdownParser alloc] init];
        
        // [Helper logAllFontNames];
        parser.paragraphFont = [UIFont fontWithName:@"Apercu-Light" size:17];
        if (parser.paragraphFont == nil) {
            NSLog(@"Lap, 't is nil");
        }
        parser.boldFontName = @"Apercu-Medium";
        parser.linkFontName = @"Apercu-Medium";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.minimumLineHeight = 18;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        // paragraphStyle.alignment = NSTextAlignmentJustified;
        
        parser.topAttributes = @{
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    });
    
    return parser;
}

+ (XNGMarkdownParser *)paragraphParserCenter {
    static dispatch_once_t onceToken;
    static XNGMarkdownParser *parser;
    dispatch_once(&onceToken, ^{
        parser = [[XNGMarkdownParser alloc] init];
        
        // [Helper logAllFontNames];
        parser.paragraphFont = [UIFont fontWithName:@"Apercu-Light" size:17];
        if (parser.paragraphFont == nil) {
            NSLog(@"Lap, 't is nil");
        }
        parser.boldFontName = @"Apercu-Medium";
        parser.linkFontName = @"Apercu-Medium";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.minimumLineHeight = 18;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        parser.topAttributes = @{
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    });
    
    return parser;
}


+ (XNGMarkdownParser *)headerParser {
    static dispatch_once_t onceToken;
    static XNGMarkdownParser *parser;
    dispatch_once(&onceToken, ^{
        parser = [[XNGMarkdownParser alloc] init];
        
        parser.paragraphFont = [UIFont fontWithName:@"Apercu-Medium" size:22];
        parser.boldFontName = @"Apercu-Medium";
        parser.linkFontName = @"Apercu-Medium";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.minimumLineHeight = 18;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        parser.topAttributes = @{
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    });
    
    return parser;
}

@end
