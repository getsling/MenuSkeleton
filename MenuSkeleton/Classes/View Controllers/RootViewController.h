//
//  RootViewController.h
//  MenuExample
//
//  Created by Kevin Renskers on 08-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import <REFrostedViewController/REFrostedViewController.h>

@interface RootViewController : REFrostedViewController

@property (readonly, nonatomic) NSArray *menu;
@property (readonly, nonatomic) NSIndexPath *currentIndexPath;

- (void)switchToControllerAtIndexPath:(NSIndexPath *)indexPath;

@end
