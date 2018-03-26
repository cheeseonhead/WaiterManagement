//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;
@class Waiter;
@class Shift;

@interface RestaurantManager : NSObject
+ (instancetype)sharedManager;

#pragma mark - CREATE
- (Restaurant *)createRestaurant:(NSString *)name;
- (Waiter *)createWaiter:(NSString *)name;
- (Shift *)createShiftStart:(NSDate*)start end:(NSDate*)end;

#pragma mark - GET
- (Restaurant*)currentRestaurant;
- (NSArray<Restaurant*>*)restaurants;

#pragma mark - POST
- (void)save;

#pragma mark - DELETE
- (void)deleteWaiter:(Waiter *)waiter;

@end
