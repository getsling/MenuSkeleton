//
//  RotationNavigationController.m
//  MenuExample
//
//  Created by Kevin Renskers on 08-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import <REFrostedViewController/REFrostedViewController.h>
#import "RotationNavigationController.h"


@implementation RotationNavigationController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController.viewControllers count] == 1 && !viewController.navigationItem.leftBarButtonItem) {
        if (navigationController.presentingViewController) {
            // Modal? Then show a close button.
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModal)];
            viewController.navigationItem.leftBarButtonItem = menuButton;
        } else {
            // Not a modal, show a menu button.
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(openMenu)];
            viewController.navigationItem.leftBarButtonItem = menuButton;
        }
    }
}

- (void)openMenu {
    [self.frostedViewController presentMenuViewController];
}

- (void)closeModal {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
