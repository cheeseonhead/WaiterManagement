//
//  Shift+CoreDataProperties.h
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Waiter;

NS_ASSUME_NONNULL_BEGIN

@interface Shift : NSManagedObject

- (NSDate *)end;

@end

@interface Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *duration;
@property (nullable, nonatomic, copy) NSDate *start;
@property (nullable, nonatomic, retain) Waiter *staff;

@end

NS_ASSUME_NONNULL_END
