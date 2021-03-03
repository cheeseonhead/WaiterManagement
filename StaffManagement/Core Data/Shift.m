//
//  Shift+CoreDataProperties.m
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Shift.h"

@implementation Shift

- (NSDate *)end {
	
	
	
	// This is an awesome comment
    NSDate * end = [self.start dateByAddingTimeInterval:self.duration.doubleValue];
    
    return end;
}

@end

@implementation Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest {
	
	
	
	// Another awesome comment
	
	return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic duration;
@dynamic start;
@dynamic staff;

@end
