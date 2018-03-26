//
//  Waiter+CoreDataProperties.m
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Waiter.h"

@implementation Waiter

@end

@implementation Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Waiter"];
}

@dynamic name;
@dynamic restaurant;
@dynamic shift;

@end
