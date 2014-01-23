//
//  MenuViewController.m
//  MenuExample
//
//  Created by Kevin Renskers on 08-01-14.
//  Copyright (c) 2014 Gangverk. All rights reserved.
//

#import "MenuViewController.h"
#import "RootViewController.h"


@implementation MenuViewController

- (NSIndexPath *)currentIndexPath {
    RootViewController *root = (RootViewController *)self.frostedViewController;
    return root.currentIndexPath;
}

- (NSArray *)menu {
    RootViewController *root = (RootViewController *)self.frostedViewController;
    return root.menu;
}

- (NSDictionary *)menuItemForIndexPath:(NSIndexPath *)indexPath {
    return self.menu[indexPath.section][@"items"][indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *menuSection = self.menu[section];
    return [menuSection[@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary *menuItem = [self menuItemForIndexPath:indexPath];

    if ([indexPath isEqual:self.currentIndexPath]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ *", menuItem[@"title"]];
    } else {
        cell.textLabel.text = menuItem[@"title"];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSNumber *hide = self.menu[section][@"hide-section-header"];
    if (hide && [hide boolValue]) {
        return nil;
    }

    return self.menu[section][@"section"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RootViewController *root = (RootViewController *)self.frostedViewController;
    [root switchToControllerAtIndexPath:indexPath];
    [root hideMenuViewController];
    [self.tableView reloadData];
}

@end
