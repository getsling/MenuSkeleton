//
//  OtherViewController.m
//  MenuExample
//
//  Created by Kevin Renskers on 08-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import <REFrostedViewController/REFrostedViewController.h>
#import "OtherViewController.h"

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad %@", self);
}

- (IBAction)openMenu:(UIBarButtonItem *)sender {
    [self.frostedViewController presentMenuViewController];
}

@end
