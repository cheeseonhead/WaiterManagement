//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "StaffManagement-Swift.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController () <ViewControllerDataSourceDelegate, UITableViewDelegate>

#pragma mark Views
@property IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

#pragma mark States
@property (nonatomic, strong) ViewControllerDataSource *dataSource;
@property (nonatomic, strong) NSArray *waiters;
@property (nonatomic, assign) Boolean isEditing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    self.dataSource = [[ViewControllerDataSource alloc] initWithRestaurantManager:[RestaurantManager sharedManager] delegate:self];
    self.tableView.dataSource = self.dataSource;
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isEditing = NO;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Test");
}

#pragma mark - Data Source Delegate

- (UITableViewCell *)waiterCellFor:(Waiter *)waiter {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = waiter.name;
    return cell;
}

#pragma mark - View Actions

- (IBAction)editTapped:(UIBarButtonItem *)sender {
    self.isEditing = !self.isEditing;
    [self renderViews];
}

- (IBAction)addTapped:(id)sender {
    UIAlertController * alert = [UIAlertController singleInputAlertWithTitle:@"Add Waiter" message:@"" confirmTitle:@"Add" placeHolder:@"Name" handler:^(NSString * _Nonnull name) {
        
        [self.dataSource addWaiter:name callback:^(Waiter * _Nonnull waiter) {
            [self.tableView reloadData];
        }];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Render

- (void)renderViews {
    [self renderEditButton];
    [self renderTableView];
}

- (void)renderEditButton {
    if(self.isEditing) {
        [self.editButton setTitle:@"Done"];
    } else {
        [self.editButton setTitle: @"Edit"];
    }
}

- (void)renderTableView {
    [self.tableView setEditing:self.isEditing animated:YES];
}

@end
