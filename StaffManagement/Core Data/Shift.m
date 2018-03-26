//
//  Shift+CoreDataClass.m
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Shift.h"

@implementation Shift

@end

@implementation Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic end;
@dynamic start;
@dynamic staff;

@end

