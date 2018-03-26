//
//  RestaurantManager.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "RestaurantManager.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Shift.h"
#import "Restaurant.h"
@interface RestaurantManager()
@property (nonatomic, retain) Restaurant *restaurant;

@end

@implementation RestaurantManager
+ (instancetype)sharedManager {
    static RestaurantManager *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - CREATE

- (Restaurant *)createRestaurant:(NSString *)name {
    NSEntityDescription *restaurantEntity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:[self getContext]];
    Restaurant * restaurant = [[Restaurant alloc] initWithEntity:restaurantEntity insertIntoManagedObjectContext:[self getContext]];
    restaurant.name = name;
    
    return restaurant;
}

- (Waiter *)createWaiter:(NSString *)name {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:[self getContext]];
    Waiter * waiter = [[Waiter alloc] initWithEntity:entity insertIntoManagedObjectContext:[self getContext]];
    waiter.name = name;
    
    return waiter;
}

- (Shift *)createShiftStart:(NSDate*)start end:(NSDate*)end {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shift" inManagedObjectContext:[self getContext]];
    Shift *shift = [[Shift alloc] initWithEntity:entity insertIntoManagedObjectContext:[self getContext]];
    shift.start = start;
    shift.end = end;
    
    return shift;
}

#pragma mark - GET

- (NSArray<Restaurant*>*)restaurants {
    
    NSError *error = nil;
    NSManagedObjectContext * context = [self getContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Restaurant"];
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return results;
}

-(Restaurant*)currentRestaurant{
    if(self.restaurant == nil)
    {
        Restaurant *aRestaurant;
        
        NSArray<Restaurant*>* restaurants = [self restaurants];
        
        if(restaurants.count > 0){
            aRestaurant = restaurants[0];
        }
        else{
            aRestaurant = [self createRestaurant:@""];
            
            Waiter *initialWaiter = [self createWaiter:@"John SmitL"];
            [aRestaurant addStaffObject:initialWaiter];
            
            [self save];
        }
        self.restaurant = aRestaurant;
    }
    return self.restaurant;
}

- (NSManagedObjectContext *)getContext {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    return appDelegate.managedObjectContext;
}

#pragma mark - PUT/POST

- (void)save {
    NSError * error;
    [[self getContext] save:&error];
}

#pragma mark - DELETE

- (void)deleteWaiter:(Waiter *)waiter {
    [[self getContext] deleteObject:waiter];
}

@end
