//
//  RestaurantManager.h
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;
@class Waiter;
@class Shift;

@interface RestaurantManager : NSObject
+ (instancetype)sharedManager;

#pragma mark - CREATE
- (Restaurant *)createRestaurant:(NSString *)name;
- (Waiter *)createWaiter:(NSString *)name;
- (Shift *)createShift:(NSDate*)start duration:(NSTimeInterval)duration;

#pragma mark - GET
- (Restaurant*)currentRestaurant;
- (NSArray<Restaurant*>*)restaurants;
- (NSArray<Waiter*>*)waitersNamed:(NSString *)name;

#pragma mark - POST
- (void)save;

#pragma mark - DELETE
- (void)delete:(NSManagedObject *)object;

@end
