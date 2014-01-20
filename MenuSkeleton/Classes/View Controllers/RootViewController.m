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
        NSString *menuname = IsPhone ? @"menu-iPhone" : @"menu-iPad";
        NSString *path = [[NSBundle mainBundle] pathForResource:menuname ofType:@"json"];
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

- (UIViewController *)controllerFromMenuItem:(NSDictionary *)menuItem {
    if (menuItem[@"storyboard-identifier"]) {
        return [UIViewController controllerFromStoryboard:menuItem[@"storyboard"] withIdentifier:menuItem[@"storyboard-identifier"]];
    } else {
        return [UIViewController initialControllerFromStoryboard:menuItem[@"storyboard"]];
    }
}

#pragma mark - Public methods

- (void)switchToControllerAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *menuItem = [self menuItemForIndexPath:indexPath];

    UIViewController *controller;

    if (menuItem[@"persistent"]) {
        controller = self.persistentControllers[indexPath];
        if (!controller) {
            controller = [self controllerFromMenuItem:menuItem];
            self.persistentControllers[indexPath] = controller;
        }
    } else {
        controller = [self controllerFromMenuItem:menuItem];
    }

    if (menuItem[@"modal"]) {
        if (!IsPhone && menuItem[@"modal-size"]) {
            controller.modalPresentationStyle = UIModalPresentationFormSheet;
        }

        [self presentViewController:controller animated:YES completion:nil];

        // Change the size of the modal if supplied
        if (!IsPhone && menuItem[@"modal-size"]) {
            NSArray *size = menuItem[@"modal-size"];
            controller.view.superview.bounds = CGRectMake(0.0, 0.0, [size[0] integerValue], [size[0] integerValue]);
        }
    } else {
        self.currentIndexPath = indexPath;
        self.contentViewController = controller;
    }
}

@end
