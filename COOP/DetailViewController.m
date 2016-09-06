//
//  DetailViewController.m
//  Detail
//
//  Created by Lieven Luyckx on 23/05/16.
//  Copyright © 2016 Cédric Brichau. All rights reserved.
//

#import "DetailViewController.h"
#import "RouteViewController.h"
#import "NSString+HTML.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myDetailTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBegin;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblIsCleared;
@property (weak, nonatomic) IBOutlet UIImageView *icnIsCleared;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layoutManager.delegate = self;
    
    // Apply styles
    [Styles setHeaderLabelStyles:self.myDetailTitle];
    [Styles setSettingsButtonImage:self.btnSettings];
    [Styles setBackButtonImage:self.btnBack];
    [Styles setButtonStyle:self.btnBegin];
    
    // Multiline title
    self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    
    // Apply walk data
    [self applyWalkData];
}

- (void) applyWalkData {
    self.lblDistance.text = [self.walk distanceAsString];
    self.lblDuration.text = [self.walk durationAsString];
    self.lblTitle.text = self.walk.walk_title;
    self.lblDescription.text = self.walk.walk_description;
    
    if(self.walk.isCleared) {
        self.lblIsCleared.text = NSLocalizedString(@"walk-done", @"Walk is done");
        self.icnIsCleared.image = [UIImage imageNamed:@"completedIcon"];
        
    } else {
        self.lblIsCleared.text = NSLocalizedString(@"walk-not-done", @"Walk is not done");
        self.icnIsCleared.image = [UIImage imageNamed:@"notCompletedIcon"];
    }
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 5; // For really wide spacing; pick your own value
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toRoute"]) {
        RouteViewController *vc = [segue destinationViewController];
        vc.walk = self.walk;
    }
}


@end
