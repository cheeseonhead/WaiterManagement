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

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController ()

#pragma mark Views
@property IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

#pragma mark States
@property (nonatomic, strong) NSArray *waiters;
@property (nonatomic, assign) Boolean isEditing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isEditing = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiters.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    Waiter *waiter = self.waiters[indexPath.row];
    cell.textLabel.text = waiter.name;
    return cell;
}

#pragma mark - Actions

- (IBAction)editTapped:(UIBarButtonItem *)sender {
    self.isEditing = !self.isEditing;
    [self renderViews];
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
    [self.tableView setEditing:self.isEditing animated:true];
}

@end
