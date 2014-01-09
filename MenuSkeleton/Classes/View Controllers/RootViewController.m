//
//  RootViewController.m
//  MenuExample
//
//  Created by Kevin Renskers on 08-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewController+Storyboard.h"


@interface RootViewController ()
@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (strong, nonatomic) NSMutableDictionary *persistentControllers;
@end


@implementation RootViewController

- (NSArray *)menu {
    if (!_menu) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _menu = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    return _menu;
}

- (NSDictionary *)menuItemForIndexPath:(NSIndexPath *)indexPath {
    return self.menu[indexPath.section][@"items"][indexPath.row];
}

- (void)awakeFromNib {
    self.persistentControllers = [NSMutableDictionary dictionary];
    self.menuViewSize = CGSizeMake(280, 0);
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self switchToControllerAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - Public methods

- (void)switchToControllerAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *menuItem = [self menuItemForIndexPath:indexPath];

    UIViewController *controller;

    if (menuItem[@"persistent"]) {
        controller = self.persistentControllers[indexPath];
        if (!controller) {
            controller = [UIViewController initialControllerFromStoryboard:menuItem[@"storyboard"]];
            self.persistentControllers[indexPath] = controller;
        }
    } else {
        controller = [UIViewController initialControllerFromStoryboard:menuItem[@"storyboard"]];
    }

    if (menuItem[@"modal"]) {
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        self.currentIndexPath = indexPath;
        self.contentViewController = controller;
    }
}

@end
