//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "TutorialPageContentViewController.h"
#import "Parser.h"

@interface TutorialPageContentViewController ()

@property (strong, nonatomic) XNGMarkdownParser *paragraphParser;
@property (strong, nonatomic) XNGMarkdownParser *headerParser;

@end

@implementation TutorialPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Markdown parsers
    self.paragraphParser = [Parser paragraphParserCenter];
    self.headerParser = [Parser headerParser];

    // Image
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    
    // Skip button
    [Styles setButtonStyleWithPadding:self.btnSkip];
    [self.btnSkip sizeToFit];
    [self.btnSkip setHidden:!self.showSkipButton];
    [self.btnSkip setTitle:self.buttonText forState:UIControlStateNormal];
    
    // Text labels
    self.titleLabel.attributedText = [self.headerParser attributedStringFromMarkdownString:self.titleText];
    self.tekst.attributedText = [self.paragraphParser attributedStringFromMarkdownString:self.tekstText];
}

- (IBAction)forwardToApp:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    [Helper changeViewControllerFrom:self toViewControllerWithIdentifier:@"NavigationController" withAnimation:NO];
}

@end
