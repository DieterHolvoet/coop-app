//
//  RootViewController.m
//  COOP
//
//  Created by ontlener on 20/05/16.
//  Copyright © 2016 Groep1. All rights reserved.
//

#import "RouteViewController.h"
#import "PoiViewController.h"
#import "Media.h"
#import "Theme.h"
#import "Parser.h"
#import "POI.h"
#import "Waypoint.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XNGMarkdownParser.h"
#import "WESlider.h"
#import "Parser.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"

@interface RouteViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *btnReadMore;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *backgroundBackView;
@property (weak, nonatomic) IBOutlet UIView *WESliderContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnPrevious;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (strong, nonatomic) NSString *codeForNext;
@property (strong, nonatomic) WESlider* slider;
@property (strong, nonatomic) XNGMarkdownParser *paragraphParser;
@property (strong, nonatomic) XNGMarkdownParser *headerParser;

@property int currentIndex;
@property int lastIndex;
@property BOOL onPOI;

@end

@implementation RouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblDescription.numberOfLines = 0;
    self.lblDescription.textAlignment = NSTextAlignmentJustified;
    
    self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    
    // Style buttons
    [Styles setButtonStyle:self.btnPrevious];
    [Styles setButtonStyle:self.btnNext];
    [Styles setBackButtonImage:self.btnBack];
    _backgroundBackView.layer.cornerRadius = 7.5;
    _btnReadMore.hidden = YES;
    
    // Initialize Markdown parsers
    self.paragraphParser = [Parser paragraphParser];
    self.headerParser = [Parser headerParser];
    
    // Initialize activity indicator
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor grayColor];
    [self.imageview addSubview: indicator];
    indicator.center = CGPointMake([Helper getScreenWidth] / 2, [Helper getScreenWidth] / 2);
    
    // Initialize WESlider
    self.slider = [[WESlider alloc] initWithWidth:CGRectGetWidth(self.view.frame) * 0.7f];
    self.slider.minimumValue = 1.0f;
    [self.WESliderContainer addSubview:self.slider];
    [self.WESliderContainer setUserInteractionEnabled:NO];
    [self.slider setMinimumTrackTintColor:[UIColor colorWithRed:252.0f / 255.0f green:204.0f / 255.0f blue:47.0f / 255.0f alpha:1.0f]];
    
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"pedestrian-walking.png"]
                                forState:UIControlStateNormal];
    
    // Fetch data from API
    [API loadWalkWithID:[self.walk.walk_id intValue]
             andSuccess:^(Walk* walk) {
                 
                 NSLog(@"ID: %@", walk.walk_id);
                 
                 // Assign properties
                 self.walk = walk;
                 self.stops = walk.stops;
                 
                 //Go back to the position they stopped last time
                 _lastIndex = [self.walk.progress intValue];
                 _currentIndex = [self.walk.progress intValue];
                 
                 // Setup WESlider
                 NSMutableArray *chunks = [[NSMutableArray alloc] init];
                 
                 if(self.stops.count == 0) {
                     UIAlertView *alert = [[UIAlertView alloc]
                                           initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"alert-walk-no-stops", @"Walk has no stops"), walk.walk_id]
                                           message:nil
                                           delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"alert-cancel", @"Cancel")
                                           otherButtonTitles:NSLocalizedString(@"alert-ok", @"OK"), nil];
                     alert.cancelButtonIndex = -1;
                     [alert show];
                 }
                 
                 for (int i = 1; i < self.stops.count - 1; i++) {
                     if([self.stops[i] isKindOfClass:POI.class]) {
                         [chunks addObject:[WEChunk chunkWithOffset:i]];
                     }
                 }
                 
                 [self.slider setMaximumValue:self.stops.count];
                 [self.slider setChunks:chunks];
                 
                 // Open current page
                 [self setPageAtIndex:_currentIndex];
                 
             } andFailure:^(NSError *error) {
                 RKLogError(@"Load failed with error: %@", error);
                 
             } andActivityIndicator:indicator];
}

-(void) viewDidLayoutSubviews {
    self.scrollView.contentSize = self.lblDescription.frame.size;
    self.slider.center = CGPointMake(self.WESliderContainer.frame.size.width / 2,
                                     self.WESliderContainer.frame.size.height / 2);
}
- (IBAction)goBackToDetail:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.walk.progress = [NSNumber numberWithInt:self.lastIndex];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

# pragma mark Button click actions

- (IBAction) btnNext:(id)sender {
    
    // Check if the walk is finished
    if((self.currentIndex + 1) == self.stops.count) {
        [Database setWalkFinished:self.walk];
        [Helper changeViewControllerFrom:self toViewControllerWithIdentifier:@"EindpaginaViewController" withAnimation:YES];
    }
    
    // Check if the user is on a Point of Interest
    if(_onPOI && [Config interactiveWalkEnabled]) {
        
        // Check if the user has a supported reader
        if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
            static QRCodeReaderViewController *vc = nil;
            static dispatch_once_t onceToken;
            
            dispatch_once(&onceToken, ^{
                QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
                vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
                vc.modalPresentationStyle = UIModalPresentationFormSheet;
            });
            vc.delegate = self;
        
            // Show the QR scanner
            [self presentViewController:vc animated:YES completion:NULL];
            
        } else {
            // Error in case the user does not have a supported reader
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert-error", @"Error") message:NSLocalizedString(@"alert-reader-not-supported", @"Reader not supported by the current device") delegate:nil cancelButtonTitle:NSLocalizedString(@"alert-ok", @"OK") otherButtonTitles:nil];
        
            [alert show];
        }
        
    } else {
        [self nextPage];
    }
}

// Called when a QR-code is succesfully scanned
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        // Go to next page if the correct code is scanned
        if([result  isEqualToString:_codeForNext]){
            [self nextPage];
            
        } else {
        // Give an error if a wrong QR-code is scanned
        
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert-error", @"Error") message:NSLocalizedString(@"alert-incorrect-qr", @"Incorrect QR code") delegate:nil cancelButtonTitle:NSLocalizedString(@"alert-ok", @"OK") otherButtonTitles:nil];
            [alert show];
        }
    }];
}

//called when the user cancelled the scan
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//get previous page
- (IBAction) btnPrevious:(id)sender {
    [self previousPage];
}

//set the page at a given index
- (void) setPageAtIndex:(int)index {
    self.currentIndex = index;
    if(_currentIndex > _lastIndex){
        _lastIndex = _currentIndex;
    }
    
    //disable Previous button on first page
    if(_currentIndex == 0) {
        _btnPrevious.hidden = YES;
        
    } else if(_btnPrevious.hidden) {
        _btnPrevious.hidden = NO;
    }
    
    NSURL *url = nil;
    
    // Fetch data from objects
    if([self.stops[index] isKindOfClass:POI.class]) {
        POI *poi = self.stops[index];
        
        // Find the first image
        for (Media *media in [poi.media allObjects]) {
            if([media.media_url hasSuffix:@".jpg"] || [media.media_url hasSuffix:@".jpeg"] || [media.media_url hasSuffix:@".png"]) {
                url = [NSURL URLWithString:media.media_url];
                break;
            }
        }
        
        // Hide waypoint description, show POI title
        _lblDescription.hidden = YES;
        _lblTitle.hidden = NO;
        _btnReadMore.hidden = NO;
        
        // Check if the POI is a new one, that hasnt been passed yet
        if(index == _lastIndex){
            _codeForNext = poi.poi_unlock_code;
            if([Config interactiveWalkEnabled]) [_btnNext setTitle:NSLocalizedString(@"button-scan-qr", @"Scan QR code to continue") forState:UIControlStateNormal];
            _onPOI = YES;
            
        } else {
            _onPOI = NO;
        }
        
        self.lblTitle.attributedText = [self.headerParser attributedStringFromMarkdownString:poi.poi_title];
        
    } else if([self.stops[index] isKindOfClass:Waypoint.class]) {
        Waypoint *waypoint = self.stops[index];
        Media *image = [waypoint.media allObjects][0];
        
        // Hide POI title, show waypoint description
        _lblTitle.hidden = YES;
        _lblDescription.hidden = NO;
        _btnReadMore.hidden = YES;
        
        [_btnNext setTitle:NSLocalizedString(@"button-next", @"Next stop") forState:UIControlStateNormal];
        _onPOI = NO;
        
        url = [NSURL URLWithString:image.media_url];
        self.lblDescription.attributedText = [self.paragraphParser attributedStringFromMarkdownString:waypoint.waypoint_description];
    }
    
    // Load image
    [self.imageview sd_setImageWithURL:url
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    // Change 'Next' button on last page
    if((self.currentIndex + 1) == self.stops.count) {
        [self.btnNext setTitle:NSLocalizedString(@"button-finish", @"Finish the walk") forState:UIControlStateNormal];
    }
    
    // Change WESlider
    [self.slider setValue:self.currentIndex + 1];
}

- (void) nextPage {
    if((self.currentIndex + 1) >= self.stops.count) {
        return;
    }
    
    [self setPageAtIndex:self.currentIndex + 1];
}

- (void) previousPage {
    if(self.currentIndex <= 0) {
        return;
    }
    
    [self setPageAtIndex:self.currentIndex - 1];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toPoi"]) {
        PoiViewController *vc = [segue destinationViewController];
        vc.poi = self.stops[self.currentIndex];
    }
}

@end
