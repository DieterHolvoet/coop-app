//
//  POIViewController.m
//  coop_POI
//
//  Created by kenny vm on 20/05/16.
//  Copyright © 2016 kenny vm. All rights reserved.
//

#import "PoiViewController.h"
#import "Media.h"
#import "Parser.h"
#import "Styles.h"
#import "XNGMarkdownParser.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>

@interface PoiViewController ()

- (IBAction)playAudio:(id)sender;
- (IBAction)changeScreen:(id)sender;
- (IBAction)audioPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pagina;
@property (weak, nonatomic) IBOutlet UILabel *POITitel;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAudio;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVPlayer *moviePlayer;
@property (strong, nonatomic) AVPlayerLayer *moviePlayerLayer;
@property (strong, nonatomic) AVAsset *asset;
@property (strong, nonatomic) AVPlayerItem *moviePlayerItem;
@property (strong, nonatomic) NSString *platform;
@property (strong, nonatomic) NSArray<Media*> *media;

@property (strong, nonatomic) XNGMarkdownParser *paragraphParser;
@property (strong, nonatomic) XNGMarkdownParser *headerParser;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIView *backgroundBackView;
@property bool isPlaying;
@property (nonatomic) float viewWidth;
@property (nonatomic) float viewHeight;

@end

@implementation PoiViewController

- (float)viewWidth {
    return self.view.frame.size.width;
}

- (float)viewHeight {
    return self.view.frame.size.height / 3;
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isPlaying = false;
    
    // Get iPhone model
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    self.platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    // Initialize Markdown parser
    self.paragraphParser = [Parser paragraphParser];
    self.headerParser = [Parser headerParser];
    
    // Set back button style
    [Styles setBackButtonImage:self.btnBack];
    _backgroundBackView.layer.cornerRadius = 7.5;
    
    // Set media
    self.media = [NSArray arrayWithArray:[self.poi.media allObjects]];
    
    // Set ScrollView width
    [self.scrollView setContentSize:CGSizeMake(self.viewWidth * self.media.count,
                                               self.scrollView.frame.size.height)];
    
    // Parse media
    for(int i = 0; i < self.media.count; i++) {
        NSString *url = self.media[i].media_url;
        
        if([url hasSuffix:@".jpg"] || [url hasSuffix:@".jpeg"] || [url hasSuffix:@".png"]) {
            [API loadImageWithURL:[NSURL URLWithString:url]
                       andSuccess:^(UIImage *image) {
                           UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i) * self.viewWidth, 0, self.viewWidth, self.viewHeight)];
                           imageView.image = image;
                           imageView.contentMode = UIViewContentModeScaleToFill;
                           
                           [self.scrollView addSubview:imageView];
                           
                       } andFailure:^(NSError *error) {
                           NSLog(@"Error: %@", error.description);
                       }];
            
        } else if([url hasSuffix:@".mp3"]) {
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
            
        } else if([url hasSuffix:@".mov"]) {
            // Encode url for accented characters STOM FRANS
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            // Initialize Player
            AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:encoded]];
            
            // Initialize PlayerViewController
            AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
            controller.player = player;
            controller.showsPlaybackControls = YES;
            
            // Add subviews
            [self addChildViewController:controller];
            [self.scrollView addSubview:controller.view];
            
            // iPhone 5, iPhone 5S, iPhone 4S
            NSSet *case1 = [NSSet setWithObjects:@"iPhone5,1", @"iPhone6,1", @"iPhone4,1", nil];
            
            // iPhone 6S, iPhone 6
            NSSet *case2 = [NSSet setWithObjects:@"iPhone8,1", @"iPhone7,2", nil];
            
            // iPhone 6S Plus, iPhone 6 Plus
            NSSet *case3 = [NSSet setWithObjects:@"iPhone8,2", @"iPhone7,1", nil];
            
            // op de simulator werkt dit niet blijkbaar, normaal op iphone wel maar niet getest
            if ([case1 containsObject:self.platform]) {
                [controller.view setFrame:CGRectMake((i) * self.view.frame.size.width, 0,
                                                     self.view.frame.size.width * 0.75,
                                                     self.viewHeight * 0.70)];
                
            } else if([case2 containsObject:self.platform]) {
                [controller.view setFrame:CGRectMake((i) * self.view.frame.size.width, 0,
                                                     self.view.frame.size.width * 0.65,
                                                     self.viewHeight * 0.60)];
                
            } else if([case3 containsObject:self.platform]) {
                [controller.view setFrame:CGRectMake((i) * self.view.frame.size.width, 0,
                                                     self.view.frame.size.width * 0.60,
                                                     self.viewHeight * 0.55)];
                
            } else {
                [controller.view setFrame:CGRectMake((i) * self.view.frame.size.width, 0,
                                                     self.view.frame.size.width * 0.75,
                                                     self.viewHeight * 0.70)];
            }
        }
        
        [self.scrollView setDelegate:self];
        
        self.pagina.numberOfPages = self.media.count;
        self.lblDescription.attributedText = [self.paragraphParser attributedStringFromMarkdownString:self.poi.poi_description];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.attributedText = [self.headerParser attributedStringFromMarkdownString:self.poi.poi_title];
        self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblTitle.numberOfLines = 0;
    }
    
    if(self.audioPlayer == nil) {
        self.btnAudio.hidden = YES;
        
    } else {
        [Styles setButtonStyle:self.btnAudio];
        self.btnAudio.layer.cornerRadius = 10;
        self.btnAudio.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.26 alpha:1.0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // http://stackoverflow.com/questions/10958661/iphone-dev-page-control-scrollviewdidscroll-not-firing
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pagina.currentPage = page;
}

- (IBAction)changeScreen:(id)sender {
    CGPoint offset = CGPointMake(self.pagina.currentPage * self.view.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (IBAction)playAudio:(id)sender {
    if(!self.isPlaying){
        [self.audioPlayer play];
        self.isPlaying = true;
        
    } else {
        [self.audioPlayer pause];
        self.isPlaying = false;
    }
}

- (IBAction)audioPressed:(id)sender{
    if (self.isPlaying){
         [sender setTitle:NSLocalizedString(@"button-play-audio", @"Play audio") forState:UIControlStateNormal];
        
    } else {
         [sender setTitle:NSLocalizedString(@"button-pause-audio", @"Pause audio") forState:UIControlStateNormal];
    }
}

@end
