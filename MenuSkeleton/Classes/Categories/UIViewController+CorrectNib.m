//
//  UIViewController+CorrectNib.m
//  ios-radiocom-universal
//
//  Created by Kevin Renskers on 13-12-12.
//  Copyright (c) 2012 CBS Local. All rights reserved.
//

#import "UIViewController+CorrectNib.h"


@implementation UIViewController (CorrectNib)

+ (id)initialControllerFromStoryboard {
    NSString *storyboardName = NSStringFromClass([self class]);
    return [self initialControllerFromStoryboard:storyboardName];
}

+ (id)controllerFromStoryboard {
    NSString *storyboardName = NSStringFromClass([self class]);
    return [self controllerFromStoryboard:storyboardName withIdentifier:storyboardName];
}

+ (id)controllerFromStoryboardWithIdentifier:(NSString *)identifier {
    NSString *storyboardName = NSStringFromClass([self class]);
    return [self controllerFromStoryboard:storyboardName withIdentifier:identifier];
}

+ (id)initialControllerFromStoryboard:(NSString *)storyboardName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateInitialViewController];
}

+ (id)controllerFromStoryboard:(NSString *)storyboardName withIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
