//
//  InterstitialViewController.m
//  MenuSkeleton
//
//  Created by Kevin Renskers on 09-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import <REFrostedViewController/REFrostedViewController.h>
#import <Google-Mobile-Ads-SDK/DFPInterstitial.h>
#import "InterstitialViewController.h"


@interface InterstitialViewController () <GADInterstitialDelegate>
@property (strong, nonatomic) DFPInterstitial *interstitial;
@end


@implementation InterstitialViewController

- (IBAction)loadInterstitial {
    self.interstitial = [[DFPInterstitial alloc] init];
    self.interstitial.adUnitID = @"/6253334/dfp_example_ad/interstitial";
    self.interstitial.delegate = self;

    // Load the ad, enable testing on simulator
    GADRequest *request = [GADRequest request];
    request.testDevices = @[GAD_SIMULATOR_ID];

    [self.interstitial loadRequest:request];
}

- (IBAction)openMenu {
    [self.frostedViewController presentMenuViewController];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    [self.interstitial presentFromRootViewController:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"No interstitial");
}

@end
