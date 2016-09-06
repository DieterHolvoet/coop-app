//
//  EindpaginaViewController.m
//  eindpagina
//
//  Created by kenny vm on 25/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import "EindpaginaViewController.h"
#import "Styles.h"
#import "Parser.h"

@interface EindpaginaViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myDetailTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBegin;
@property (weak, nonatomic) IBOutlet UIButton *btnDeelMijnWandeling;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblIsCleared;
@property (weak, nonatomic) IBOutlet UIImageView *icnIsCleared;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;

- (IBAction)shareOnFacebook:(id)sender;

@end

@implementation EindpaginaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layoutManager.delegate = self;
    
    // Apply styles
    [Styles setHeaderLabelStyles:self.myDetailTitle];
    [Styles setSettingsButtonImage:self.btnSettings];
    [Styles setBackButtonImage:self.btnBack];
    [Styles setButtonStyle:self.btnBegin];
    [Styles setButtonStyle:self.btnDeelMijnWandeling];
    
    NSString *text = [NSString stringWithFormat:@"%@\n\n%@", NSLocalizedString(@"trophy-history", @"History trophy"), NSLocalizedString(@"want-more", @"")];
    self.textView.attributedText = [[Parser paragraphParserCenter] attributedStringFromMarkdownString:text];
}

- (IBAction)goBack:(id)sender {
    [Helper changeViewControllerFrom:self toViewControllerWithIdentifier:@"ListViewController" withAnimation:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 5; // For really wide spacing; pick your own value
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"finishWalk"]) {
        //ListViewController *vc = [segue destinationViewController];
        //vc.walk = self.walk;
    }
}

- (IBAction)shareOnFacebook:(id)sender {
    
    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeMessage,
                                   UIActivityTypePrint,
                                   UIActivityTypeCopyToPasteboard,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypePostToTencentWeibo,
                                   UIActivityTypeAirDrop];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
