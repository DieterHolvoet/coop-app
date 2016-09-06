//
//  MapViewController.m
//  mapboxTest
//
//  Created by Lieven Luyckx on 20/05/16.
//  Copyright © 2016 Lieven Luyckx. All rights reserved.
//

#import "MapViewController.h"
#import "AverageLocation.h"
#import "Theme.h"
@import Mapbox;

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnKaart;
@property (weak, nonatomic) IBOutlet MGLMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnLijst;
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Hide navigation bar
    self.navigationController.navigationBarHidden = YES;
    
    // Apply styles
    [Styles setHeaderLabelStyles:self.myTitle];
    [Styles setSettingsButtonImage:self.btnSettings];
    [Styles setTabButtonStyles:self.btnLijst];
    [Styles setTabButtonStyles:self.btnKaart];
    
    // Add annotations to map
    [self.mapView addAnnotations:self.walks];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}

- (MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation {
    
    Walk *walk = annotation;
    MGLAnnotationImage *annotationImage = [mapView dequeueReusableAnnotationImageWithIdentifier:walk.theme.identifier];
    
    if(annotationImage == nil) {
        UIImage *image;
        
        switch ([walk.theme.theme_id intValue]) {
            case 1:
                image = [UIImage imageNamed:@"bevolkingAnnotation"];
                break;
                
            case 2:
                image = [UIImage imageNamed:@"milieuAnnotation"];
                break;
                
            case 3:
                image = [UIImage imageNamed:@"geschiedenisAnnotation"];
                break;
                
            default:
                image = [UIImage imageNamed:@"geschiedenisAnnotation"];
                break;
        }
        
        image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, image.size.height / 2, 0)];
        annotationImage = [MGLAnnotationImage annotationImageWithImage:image reuseIdentifier:walk.theme.identifier];
    }
    
    return annotationImage;
}

@end
