//
//  ViewController.m
//  Curiosity
//
//  Created by Alexey Baryshnikov on 26.08.2020.
//  Copyright © 2020 Alexey Baryshnikov. All rights reserved.
//

#import "ViewController.h"
#import "ABMarsData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Sensors data";
#pragma mark Background
    self.view.backgroundColor = UIColor.whiteColor;
    UIImageView *backgroundImage = [[UIImageView alloc] init];
    
    backgroundImage.image = [UIImage imageNamed:@"mars.jpg"];
    backgroundImage.alpha = 0.75f;
    [self.view addSubview:backgroundImage];
    backgroundImage.translatesAutoresizingMaskIntoConstraints = NO;
    [backgroundImage.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = YES;
    [backgroundImage.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = YES;
    [backgroundImage.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0].active = YES;
    [backgroundImage.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    
#pragma mark Text representation
    UITextView *textSection = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    textSection.backgroundColor = UIColor.clearColor;
    textSection.translatesAutoresizingMaskIntoConstraints = NO;
    
    
#pragma mark URLSession
    NSString *baseURLString = @"https://api.maas2.apollorion.com/";
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:baseURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
        }
            
        ABMarsData *jsonData = [ABMarsData fromData:data error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            textSection.text = [NSString stringWithFormat:@"Curiosity rover data\n\nmax temp: %ld °C\nmin temp: %ld °C\nsol: %ld\nseason: %@\natmospher opacity: %@\npressure: %@ %ld kPa\nUV index: %@", [jsonData maxTemp], [jsonData minTemp], [jsonData sol], [jsonData season], [jsonData atmoOpacity], [jsonData pressureString], [jsonData pressure], [jsonData localUvIrradianceIndex]];
            [textSection setFont:[UIFont fontWithName:@"Copperplate" size:22]];
        });
        
    }];
    [dataTask resume];
#pragma mark mainStackView
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UIAxisVertical;
    mainStackView.distribution = UIStackViewDistributionFillProportionally;
    mainStackView.spacing = 20.f;
    
    [mainStackView addSubview:textSection];
    [self.view addSubview:mainStackView];
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20].active = YES;
    [mainStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:20].active = YES;
    [mainStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [mainStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:20].active = YES;
    
    [textSection.leadingAnchor constraintEqualToAnchor:mainStackView.leadingAnchor constant:20].active = YES;
    [textSection.topAnchor constraintEqualToAnchor:mainStackView.topAnchor constant:20].active = YES;
    [textSection.bottomAnchor constraintEqualToAnchor:mainStackView.bottomAnchor constant:-20].active = YES;
    [textSection.trailingAnchor constraintEqualToAnchor:mainStackView.trailingAnchor constant:-20].active = YES;
}


@end
