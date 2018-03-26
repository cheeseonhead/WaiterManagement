//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
@interface RestaurantManager : NSObject
+ (instancetype)sharedManager;

#pragma mark - CREATE
- (Restaurant *)createRestaurant:(NSString *)name;
- (Waiter *)createWaiter:(NSString *)name;

#pragma mark - GET
- (Restaurant*)currentRestaurant;
- (NSArray<Restaurant*>*)restaurants;

#pragma mark - POST
- (void)save;

#pragma mark - DELETE
- (void)deleteWaiter:(Waiter *)waiter;

@end
